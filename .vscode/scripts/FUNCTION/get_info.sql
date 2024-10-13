-- Удаляем существующую функцию, если она существует
DROP FUNCTION IF EXISTS metric.get_info(bigint, text, text);

-- Создаем новую функцию metric.get_info
CREATE OR REPLACE FUNCTION metric.get_info(
    p_main_id bigint,
    p_thread_type text,
    p_tolerance text
)
RETURNS TABLE (
    id bigint,
    diameter double precision,
    pitch double precision,
    tolerance text,
    type_pitch bigint,
    range_main bigint,
    range_sub bigint,
    thread_depth double precision,
    major_diam_min double precision, -- Минимальное значение внешнего диаметра
    major_diam_avg double precision, -- Среднее значение внешнего диаметра
    major_diam_max double precision, -- Максимальное значение внешнего диаметра
    pitch_diam_min double precision, -- Минимальное значение диаметра по шагу
    pitch_diam_avg double precision, -- Среднее значение диаметра по шагу
    pitch_diam_max double precision, -- Максимальное значение диаметра по шагу
    minor_diam_min double precision, -- Минимальное значение малого диаметра
    minor_diam_avg double precision, -- Среднее значение малого диаметра
    minor_diam_max double precision, -- Максимальное значение малого диаметра
    pitch_diam_d2 double precision,
    minor_diam_d1 double precision,
    minor_diam_d3 double precision,
    h double precision,
    h_5_8 double precision,
    h_3_8 double precision,
    h_4 double precision,
    h_8 double precision,
    d_es double precision,
    d_ei double precision,
    d1_es double precision,
    d1_ei double precision,
    d2_es double precision,
    d2_ei double precision
)
LANGUAGE plpgsql
AS $$
DECLARE
    row_data metric.main%ROWTYPE;
    row_json jsonb;
    key_d_es text;
    key_d_ei text;
    key_d1_es text;
    key_d1_ei text;
    key_d2_es text;
    key_d2_ei text;
    lower_tolerance text := lower(p_tolerance);  -- Преобразуем p_tolerance в нижний регистр
BEGIN
    -- Валидация типа резьбы
    IF p_thread_type NOT IN ('f', 'm') THEN
        RAISE EXCEPTION 'Недопустимый тип резьбы. Используйте ''f'' или ''m''.';
    END IF;
    
    -- Валидация параметра tolerance
    IF p_tolerance IS NULL OR p_tolerance = '' THEN
        RAISE EXCEPTION 'Параметр tolerance не может быть NULL или пустым.';
    END IF;
    
    -- Извлечение строки по заданному id с явным указанием таблицы для колонки id
    SELECT * INTO row_data 
    FROM metric.main 
    WHERE metric.main.id = p_main_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Запись с id = % не найдена.', p_main_id;
    END IF;
    
    -- Конвертация строки в JSONB для удобного доступа к колонкам
    row_json := to_jsonb(row_data);
    
    -- Формирование полных имен ключей для квалитетов с использованием lower_tolerance
    key_d_es := lower_tolerance || '_d_es_' || p_thread_type;
    key_d_ei := lower_tolerance || '_d_ei_' || p_thread_type;
    key_d1_es := lower_tolerance || '_d1_es_' || p_thread_type;
    key_d1_ei := lower_tolerance || '_d1_ei_' || p_thread_type;
    key_d2_es := lower_tolerance || '_d2_es_' || p_thread_type;
    key_d2_ei := lower_tolerance || '_d2_ei_' || p_thread_type;
    
    -- Извлечение значений квалитетов, допускающих NULL
    d_es := CASE WHEN row_json ? key_d_es THEN (row_json ->> key_d_es)::double precision ELSE NULL END;
    d_ei := CASE WHEN row_json ? key_d_ei THEN (row_json ->> key_d_ei)::double precision ELSE NULL END;
    d1_es := CASE WHEN row_json ? key_d1_es THEN (row_json ->> key_d1_es)::double precision ELSE NULL END;
    d1_ei := CASE WHEN row_json ? key_d1_ei THEN (row_json ->> key_d1_ei)::double precision ELSE NULL END;
    d2_es := CASE WHEN row_json ? key_d2_es THEN (row_json ->> key_d2_es)::double precision ELSE NULL END;
    d2_ei := CASE WHEN row_json ? key_d2_ei THEN (row_json ->> key_d2_ei)::double precision ELSE NULL END;
    
    -- Проверка наличия хотя бы одного значения квалитета
    IF d_ei IS NULL AND d_es IS NULL AND d1_ei IS NULL AND d1_es IS NULL AND d2_ei IS NULL AND d2_es IS NULL THEN
        RAISE EXCEPTION 'В базе данных нет квалитетов для id = %, thread_type = %, tolerance = %.', 
                        p_main_id, p_thread_type, p_tolerance;
    END IF;
    
    -- Вычисление major_diam_max и major_diam_min
    IF p_thread_type = 'f' THEN
        -- Для типа резьбы "f" major_diam_max = diameter + d1_es
        major_diam_max := row_data.diameter + COALESCE(d1_es, 0);  -- Если d1_es = NULL, то берём 0
    ELSE
        -- Для типа резьбы "m" major_diam_max = diameter + d_es
        major_diam_max := row_data.diameter + COALESCE(d_es, 0);  -- Если d_es = NULL, то берём 0
    END IF;
    major_diam_min := row_data.diameter + COALESCE(d_ei, 0);  -- Для обоих типов
    major_diam_avg := (major_diam_max + major_diam_min) / 2;  -- Среднее значение
    
    -- Вычисление pitch_diam_max и pitch_diam_min
    pitch_diam_max := row_data.pitch_diam_d2 + COALESCE(d2_es, 0);  -- Если d2_es = NULL, то берём 0
    pitch_diam_min := row_data.pitch_diam_d2 + COALESCE(d2_ei, 0);  -- Если d2_ei = NULL, то берём 0
    pitch_diam_avg := (pitch_diam_max + pitch_diam_min) / 2;  -- Среднее значение
    
    -- Вычисление minor_diam_max и minor_diam_min для обоих типов резьбы
    IF p_thread_type = 'f' THEN
        -- Для типа резьбы f
        minor_diam_max := row_data.minor_diam_d1 + COALESCE(d1_es, 0);  -- Если d1_es = NULL, то берём 0
        minor_diam_min := major_diam_min - 2 * row_data.thread_depth;  -- Используем ранее вычисленное major_diam_min
    ELSE
        -- Для типа резьбы m
        minor_diam_max := row_data.minor_diam_d1 + COALESCE(d1_es, 0);  -- Если d1_es = NULL, то берём 0
        minor_diam_min := major_diam_min - 2 * row_data.thread_depth;  -- Применение глубины резьбы
    END IF;
    minor_diam_avg := (minor_diam_max + minor_diam_min) / 2;  -- Среднее значение

    -- Возвращение результата с дополнительными колонками и квалитетами
    RETURN QUERY SELECT 
        row_data.id,
        row_data.diameter,
        row_data.pitch,
        p_tolerance AS tolerance, 
        row_data.type_pitch,
        row_data.range_main,
        row_data.range_sub,
        row_data.thread_depth,
        major_diam_min, 
        major_diam_avg, -- Новая колонка для среднего значения внешнего диаметра
        major_diam_max,
        pitch_diam_min, 
        pitch_diam_avg, -- Новая колонка для среднего значения диаметра по шагу
        pitch_diam_max,
        minor_diam_min,  
        minor_diam_avg, -- Новая колонка для среднего значения малого диаметра
        minor_diam_max,
        row_data.pitch_diam_d2,
        row_data.minor_diam_d1,
        row_data.minor_diam_d3,
        row_data.h,
        row_data.h_5_8,
        row_data.h_3_8,
        row_data.h_4,
        row_data.h_8,
        d_es,
        d_ei,
        d1_es,
        d1_ei,
        d2_es,
        d2_ei
    ;
END;
$$;
