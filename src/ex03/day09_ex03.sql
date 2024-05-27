DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;
DROP TRIGGER IF EXISTS trg_person_update_audit ON person;
DROP TRIGGER IF EXISTS trg_person_delete_audit ON person;
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_update_audit;
DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit;
TRUNCATE TABLE person_audit;

CREATE OR REPLACE FUNCTION trg_person_audit() RETURNS TRIGGER AS
    $body$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO person_audit VALUES
            (
                CURRENT_TIMESTAMP,
                'I',
                NEW.*
            );
            RETURN NULL;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO person_audit VALUES
            (
                CURRENT_TIMESTAMP,
                'U',
                OLD.*
            );
            RETURN NULL;
        ELSIF (TG_OP = 'DELETE') THEN
            INSERT INTO person_audit VALUES
            (
                CURRENT_TIMESTAMP,
                'D',
                OLD.*
            );
            RETURN NULL;
        END IF;
    END;
    $body$
    LANGUAGE plpgsql;

CREATE TRIGGER trg_person_audit
    AFTER INSERT OR UPDATE OR DELETE ON person FOR EACH ROW EXECUTE FUNCTION trg_person_audit();

INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');
UPDATE person SET name = 'Bulat' WHERE id = 10;
UPDATE person SET name = 'Damir' WHERE id = 10;
DELETE FROM person WHERE id = 10;
