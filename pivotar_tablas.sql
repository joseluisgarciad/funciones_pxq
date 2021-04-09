CREATE TABLE t (Section CHAR(1), Status VARCHAR(10), Count integer);

INSERT INTO t VALUES ('A', 'Active',   1);
INSERT INTO t VALUES ('A', 'Inactive', 2);
INSERT INTO t VALUES ('B', 'Active',   4);
INSERT INTO t VALUES ('B', 'Inactive', 5);

CREATE EXTENSION tablefunc;

SELECT row_name AS Section,
       category_1::integer AS Active,
       category_2::integer AS Inactive
FROM crosstab('select section::text, status, count::text from t',2)
            AS ct (row_name text, category_1 text, category_2 text);