-- Удаляем существующую функцию, если она существует
DROP FUNCTION IF EXISTS metric.get_tolerance(bigint, text);

-- Создаем новую функцию metric.get_tolerance
CREATE OR REPLACE FUNCTION metric.get_tolerance(
    p_main_id bigint,
    p_thread_type text
)
RETURNS TABLE (
    main_id bigint,
    thread_info text
)
LANGUAGE plpgsql
AS $$
DECLARE
    row_data metric.main%ROWTYPE;
    json_data jsonb;
    tol_array text[];
BEGIN
    -- Валидация типа резьбы
    IF p_thread_type NOT IN ('external', 'internal') THEN
        RAISE EXCEPTION 'Недопустимый тип резьбы. Используйте ''external'' или ''internal''.';
    END IF;

    -- Извлечение строки по заданному id с использованием алиаса
    SELECT * INTO row_data 
    FROM metric.main m 
    WHERE m.id = p_main_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Запись с id = % не найдена.', p_main_id;
    END IF;

    -- Преобразование строки в JSONB для удобной обработки
    json_data := to_jsonb(row_data);

    -- Сбор квалитетов на основе типа резьбы
    IF p_thread_type = 'external' THEN
        tol_array := (
            SELECT ARRAY_AGG(DISTINCT split_part(key, '_', 1) ORDER BY split_part(key, '_', 1))
            FROM jsonb_each_text(json_data)
            WHERE key LIKE '%\_f' ESCAPE '\' AND value IS NOT NULL
        );
    ELSE -- internal
        tol_array := (
            SELECT ARRAY_AGG(DISTINCT split_part(key, '_', 1) ORDER BY split_part(key, '_', 1))
            FROM jsonb_each_text(json_data)
            WHERE key LIKE '%\_m' ESCAPE '\' AND value IS NOT NULL
        );
    END IF;

    -- Проверка наличия квалитетов и формирование итоговых строк
    IF tol_array IS NULL OR array_length(tol_array, 1) = 0 THEN
        -- Если квалитеты не определены, возвращаем одну строку с "Не определено"
        RETURN QUERY 
        SELECT 
            m.id AS main_id, 
            FORMAT('M %s x %s - %s', row_data.diameter, row_data.pitch, 'Не определено')
        FROM metric.main m
        WHERE m.id = p_main_id;
    ELSE
        -- Возвращаем отдельную строку для каждого квалитета
        RETURN QUERY 
        SELECT 
            m.id AS main_id, 
            FORMAT('M %s x %s - %s', row_data.diameter, row_data.pitch, 
                   CASE 
                       WHEN p_thread_type = 'external' THEN UPPER(tol)
                       ELSE tol
                   END
            )
        FROM metric.main m
        CROSS JOIN unnest(tol_array) AS tol
        WHERE m.id = p_main_id;
    END IF;
END;
$$;
