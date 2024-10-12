-- ========================================
-- Удаляем существующую функцию, если она существует
-- ========================================
DROP FUNCTION IF EXISTS metric.get_pitch(double precision, character varying);

-- ========================================
-- Создаем новую функцию metric.get_pitch
-- ========================================
CREATE OR REPLACE FUNCTION metric.get_pitch(
    diameter_input DOUBLE PRECISION, -- Входной диаметр для поиска
    locale VARCHAR DEFAULT 'en'       -- Локаль для текстовых описаний (по умолчанию 'en')
)
RETURNS TABLE(
    id BIGINT,          -- Идентификатор записи (NULL для заголовков)
    type BIGINT,      -- Тип записи ('1 header' или '2 value')
    description TEXT   -- Текстовое описание
)
LANGUAGE SQL
AS $$
    -- ========================================
    -- Общие Табличные Выражения (CTE)
    -- ========================================
    WITH 
    -- ----------------------------------------
    -- pitch_data: Собирает данные по заданному диаметру с текстовыми описаниями
    -- ----------------------------------------
    pitch_data AS (
        SELECT 
            main.id,
            main.type_pitch,
            -- Генерация текстового описания типа шага в зависимости от локализации
            CASE main.type_pitch
                WHEN 1 THEN CASE WHEN locale = 'ru' THEN 'Основной шаг (Крупный)' ELSE 'Coarse' END
                WHEN 2 THEN CASE WHEN locale = 'ru' THEN 'Мелкий шаг' ELSE 'Fine' END
                WHEN 3 THEN CASE WHEN locale = 'ru' THEN 'Супер мелкий шаг' ELSE 'Extra Fine' END
                ELSE CASE WHEN locale = 'ru' THEN 'Неизвестный' ELSE 'Unknown' END
            END AS type_pitch_text,
            -- Формирование описания в формате 'M [диаметр] x [шаг]'
            FORMAT('M %s x %s', main.diameter, main.pitch) AS description,
            -- Нумерация строк внутри каждой группы type_pitch для упорядочивания
            ROW_NUMBER() OVER (PARTITION BY main.type_pitch ORDER BY main.pitch DESC) AS rn
        FROM metric.main AS main
        WHERE main.diameter = diameter_input
    ),
    
    -- ----------------------------------------
    -- headers: Создает заголовки для каждого типа шага
    -- ----------------------------------------
    headers AS (
        SELECT DISTINCT
            NULL::BIGINT AS id,           -- Заголовки не имеют идентификатора
            1::BIGINT AS type,    -- Тип записи: 'header'
            type_pitch_text AS description, -- Текст заголовка
            type_pitch
        FROM pitch_data
    ),
    
    -- ----------------------------------------
    -- values: Извлекает значения шагов с соответствующими id
    -- ----------------------------------------
    values AS (
        SELECT
            id,
            2 AS type,              -- Тип записи: 'value'
            description AS description,    -- Описание шага
            type_pitch
        FROM pitch_data
    ),
    
    -- ----------------------------------------
    -- combined: Объединяет заголовки и значения для окончательного результата
    -- ----------------------------------------
    combined AS (
        -- Добавляем заголовки
        SELECT 
            headers.type_pitch,
            headers.description,
            headers.type,
            headers.id,
            NULL AS rn                     -- Заголовки не имеют номера строки
        FROM headers
        
        UNION ALL
        
        -- Добавляем значения, связывая их с pitch_data для получения номера строки
        SELECT
            values.type_pitch,
            values.description,
            values.type,
            values.id,
            pd.rn
        FROM values
        JOIN pitch_data pd ON values.id = pd.id
    )
    
    -- ========================================
    -- Финальный SELECT: Формирует итоговый набор данных
    -- ========================================
    SELECT
        id,
        type,
        description
    FROM combined
    ORDER BY 
        type_pitch, -- Сортировка по типу шага
        -- Сначала выводим заголовки, затем значения
        CASE 
            WHEN type = 1 THEN 0
            ELSE 1
        END,
        rn; -- Внутри значений сортируем по номеру строки (убывание шага)
$$;
