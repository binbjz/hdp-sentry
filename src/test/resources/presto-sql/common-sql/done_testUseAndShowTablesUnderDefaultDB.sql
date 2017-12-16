USE default;

SHOW TABLES;
SHOW TABLES LIKE 'tbl%';

SHOW TABLES FROM default;
SHOW TABLES FROM default LIKE 'tbl%';

/*
8.31. SHOW TABLES

Synopsis

SHOW TABLES [ FROM schema ] [ LIKE pattern ]
Description

List the tables in schema or in the current schema. The LIKE clause can be used to restrict the list of table names.
*/
