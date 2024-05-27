CREATE TABLE person_audit
(
    created TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    type_event CHAR(1) DEFAULT 'I' NOT NULL,
    row_id BIGINT NOT NULL,
    name VARCHAR,
    age INTEGER,
    gender VARCHAR,
    address VARCHAR,
    CONSTRAINT ch_type_event CHECK(type_event IN('I', 'D', 'U'))
);

CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit() RETURNS TRIGGER AS
    $body$
    BEGIN
        INSERT INTO person_audit VALUES
        (
            CURRENT_TIMESTAMP,
            'I',
            NEW.*
        );
        RETURN NULL;
    END;
    $body$
LANGUAGE plpgsql;

CREATE TRIGGER trg_person_insert_audit
    AFTER INSERT ON person FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_insert_audit();

INSERT INTO person(id, name, age, gender, address) VALUES
(
    10,
    'Damir',
    22,
    'male',
    'Irkutsk'
);
