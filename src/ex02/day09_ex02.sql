CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit() RETURNS TRIGGER AS
    $body$
    BEGIN
        INSERT INTO person_audit VALUES
        (
            CURRENT_TIMESTAMP,
            'D',
            OLD.*
        );
        RETURN NULL;
    END;
    $body$
    LANGUAGE plpgsql;

CREATE TRIGGER trg_person_delete_audit
    AFTER DELETE ON person FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_delete_audit();

DELETE FROM person WHERE id = 10;
