CREATE OR REPLACE FUNCTION fnc_fibonacci(IN pstop INTEGER DEFAULT 10)
    RETURNS TABLE(fibonacci BIGINT) AS
    $$
        WITH RECURSIVE cte_fib(prev) AS
        (
            SELECT 0 AS prev, 1 AS next
            UNION ALL
            SELECT next, prev + next FROM cte_fib WHERE next < pstop
        )
        SELECT prev FROM cte_fib;
    $$
    LANGUAGE sql;


SELECT * FROM fnc_fibonacci(100);

SELECT * FROM fnc_fibonacci();
