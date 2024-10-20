CREATE OR REPLACE FUNCTION metric.get_diameters(
    order_direction TEXT -- Направление сортировки: 'ASC' или 'DESC'
)
RETURNS TABLE(
    id BIGINT,                 -- Идентификатор записи
    description VARCHAR,       -- Описание диаметра в формате 'M [диаметр]'
    diameter DOUBLE PRECISION  -- Значение диаметра
)
LANGUAGE SQL
AS $$
    SELECT DISTINCT ON (main.diameter)
        main.id,
        FORMAT('M %s', main.diameter)::VARCHAR AS description,
        main.diameter
    FROM 
        metric.main AS main
    ORDER BY 
        main.diameter, 
        CASE 
            WHEN $1 = 'ASC' THEN main.diameter
        END ASC,
        CASE 
            WHEN $1 = 'DESC' THEN main.diameter
        END DESC;
$$;
