-- ========================================
-- Удаляем существующую функцию, если она существует
-- ========================================
DROP FUNCTION IF EXISTS metric.get_diameters(text);

-- ========================================
-- Создаем новую функцию metric.get_diameters
-- ========================================
CREATE OR REPLACE FUNCTION metric.get_diameters(
    order_direction TEXT -- Направление сортировки: 'ASC' или 'DESC'
)
RETURNS TABLE(
    id BIGINT,                 -- Идентификатор записи
    description VARCHAR,       -- Описание диаметра в формате 'M [диаметр]'
    diameter DOUBLE PRECISION  -- Значение диаметра
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- ========================================
    -- Валидация входного параметра order_direction
    -- ========================================
    IF order_direction NOT IN ('ASC', 'DESC') THEN
        RAISE EXCEPTION 'Invalid order direction. Use ''ASC'' or ''DESC''.';
    END IF;

    -- ========================================
    -- Выполнение запроса с указанным направлением сортировки
    -- ========================================
    RETURN QUERY
    SELECT 
        main.id,
        FORMAT('M %s', main.diameter)::VARCHAR AS description,
        main.diameter
    FROM 
        metric.main AS main
    ORDER BY 
        -- Динамическое направление сортировки без использования EXECUTE
        -- Используем CASE для определения направления
        CASE 
            WHEN order_direction = 'ASC' THEN main.diameter
        END ASC,
        CASE 
            WHEN order_direction = 'DESC' THEN main.diameter
        END DESC;
END;
$$;
