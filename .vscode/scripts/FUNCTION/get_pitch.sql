-- Удаляем существующую функцию, если она существует
DROP FUNCTION IF EXISTS metric.get_pitch(double precision, character varying);

-- Создаем новую функцию
CREATE OR REPLACE FUNCTION metric.get_pitch(diameter_input double precision, locale character varying DEFAULT 'en')
RETURNS TABLE(id bigint, type character varying, result_text text)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
    current_type_pitch character varying;
BEGIN
    FOR rec IN
        SELECT main.id,
               main.type_pitch,
               CASE main.type_pitch
                   WHEN 1 THEN CASE locale WHEN 'ru' THEN 'Основной шаг (Крупный)' ELSE 'Coarse' END
                   WHEN 2 THEN CASE locale WHEN 'ru' THEN 'Мелкий шаг' ELSE 'Fine' END
                   WHEN 3 THEN CASE locale WHEN 'ru' THEN 'Супер мелкий шаг' ELSE 'Extra Fine' END
                   ELSE CASE locale WHEN 'ru' THEN 'Неизвестный' ELSE 'Unknown' END
               END AS type_pitch_text,
               format('M %s x %s', main.diameter, main.pitch)::character varying AS description
        FROM metric.main AS main
        WHERE main.diameter = diameter_input
        ORDER BY main.type_pitch, main.pitch DESC
    LOOP
        -- Добавляем заголовок, если изменился тип pitch
        IF current_type_pitch IS DISTINCT FROM rec.type_pitch::character varying THEN
            current_type_pitch := rec.type_pitch::character varying;
            id := NULL;  -- Заголовок не имеет id
            type := 'header';
            result_text := rec.type_pitch_text;
            RETURN NEXT;
        END IF;

        -- Добавляем описание с оригинальным id
        id := rec.id;
        type := 'value';
        result_text := rec.description;
        RETURN NEXT;
    END LOOP;
END;
$$;
