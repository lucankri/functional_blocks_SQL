CREATE OR REPLACE FUNCTION fnc_persons(IN pgender varchar DEFAULT 'female') RETURNS TABLE
    (
        id person.id%TYPE,
        name person.name%TYPE,
        age person.age%TYPE,
        gender person.gender%TYPE,
        address person.address%TYPE
    ) AS
    $$
        SELECT * FROM person WHERE gender IN(pgender);
    $$
    LANGUAGE sql;

SELECT * FROM fnc_persons(pgender := 'male');

SELECT * FROM fnc_persons();
