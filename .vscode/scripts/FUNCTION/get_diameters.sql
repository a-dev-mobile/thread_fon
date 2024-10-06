-- Удаляем существующую функцию, если она существует
DROP FUNCTION IF EXISTS metric.get_diameters(text);

-- Создаем новую функцию с обновленным типом возвращаемого значения
CREATE OR REPLACE FUNCTION metric.get_diameters(order_direction text)
RETURNS TABLE(id bigint, description character varying, diameter double precision)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Проверяем корректность аргумента order_direction
    IF order_direction NOT IN ('ASC', 'DESC') THEN
        RAISE EXCEPTION 'Invalid order direction. Use ''ASC'' or ''DESC''.';
    END IF;

    -- Выполняем запрос с динамическим указанием направления сортировки
    RETURN QUERY EXECUTE format(
        'SELECT id, format(''M %%s'', diameter)::character varying AS description, diameter FROM metric.main ORDER BY diameter %s',
        order_direction
    );
END;
$$;
