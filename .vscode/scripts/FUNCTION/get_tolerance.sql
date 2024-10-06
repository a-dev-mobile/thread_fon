-- Удаляем существующую функцию, если она существует
DROP FUNCTION IF EXISTS metric.get_tolerance(bigint, text);

-- Создаем новую функцию metric.get_tolerance
CREATE OR REPLACE FUNCTION metric.get_tolerance(
    p_main_id bigint,
    p_thread_type text
)
RETURNS TABLE (
    main_id bigint,
    description text,
    tolerance text
)
LANGUAGE plpgsql
AS $$
DECLARE
    row_data metric.main%ROWTYPE;
    tol_array text[];
    thread_suffix text;
BEGIN
    -- Валидация типа резьбы
    IF p_thread_type NOT IN ('female', 'male') THEN
        RAISE EXCEPTION 'Недопустимый тип резьбы. Используйте ''female'' или ''male''.';
    END IF;

    -- Определяем суффикс для фильтрации ключей JSON
    thread_suffix := CASE 
                        WHEN p_thread_type = 'female' THEN '_f' 
                        ELSE '_m' 
                     END;

    -- Извлечение строки по заданному id
    SELECT * INTO row_data 
    FROM metric.main 
    WHERE id = p_main_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Запись с id = % не найдена.', p_main_id;
    END IF;

    -- Сбор квалитетов на основе типа резьбы
    SELECT ARRAY_AGG(DISTINCT split_part(key, '_', 1) ORDER BY split_part(key, '_', 1))
    INTO tol_array
    FROM jsonb_each_text(to_jsonb(row_data)) AS jt(key, value)
    WHERE key LIKE '%' || thread_suffix AND value IS NOT NULL;

    -- Проверка наличия квалитетов и обработка результата
    IF tol_array IS NULL OR array_length(tol_array, 1) = 0 THEN
        -- Если квалитеты не определены, генерируем ошибку
        RAISE EXCEPTION 'В базе данных нет квалитетов для main_id = % и thread_type = %.', p_main_id, p_thread_type;
    ELSE
        -- Возвращаем отдельную строку для каждого квалитета с сохранением названия допуска в description
        RETURN QUERY 
        SELECT 
            row_data.id AS main_id, 
            FORMAT('M %s x %s - %s', row_data.diameter, row_data.pitch, 
                   CASE 
                       WHEN p_thread_type = 'female' THEN UPPER(tol)
                       ELSE tol
                   END
            ) AS description,
            CASE 
                WHEN p_thread_type = 'female' THEN UPPER(tol)
                ELSE tol
            END AS tolerance
        FROM unnest(tol_array) AS tol;
    END IF;
END;
$$;
