CREATE OR REPLACE FUNCTION analytics.update_or_insert_thread(
    p_thread VARCHAR  -- Название резьбы
)
RETURNS VOID
LANGUAGE SQL
AS $$
    -- Попытка обновить счетчик для существующей записи
    WITH updated AS (
        UPDATE analytics.popular
        SET use = use + 1
        WHERE thread = p_thread
        RETURNING *
    )
    -- Если обновление не произошло, то вставляем новую запись
    INSERT INTO analytics.popular (thread, use)
    SELECT p_thread, 1
    WHERE NOT EXISTS (SELECT 1 FROM updated);
$$;
