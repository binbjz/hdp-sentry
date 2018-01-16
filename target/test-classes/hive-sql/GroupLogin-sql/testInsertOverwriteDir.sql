USE mart_waimai;

INSERT OVERWRITE LOCAL DIRECTORY '/tmp/ca_employees'
SELECT * FROM mart_waimai.src_employees_insert_overwrite se WHERE se.country = 'US' and se.state = 'CA';
!ls -l /tmp/ca_employees;
!rm -r /tmp/ca_employees;

FROM (
SELECT emp.name, emp.salary FROM mart_waimai.src_employees_insert_overwrite emp WHERE emp.salary < 6000
UNION ALL
SELECT emp.name, emp.salary FROM mart_waimai.src_employees_insert_overwrite emp WHERE emp.salary > 7000
) unioninput
INSERT OVERWRITE DIRECTORY '/tmp/union.out' SELECT unioninput.*;
dfs -cat /tmp/union.out/* ;
dfs -rm -r /tmp/union.out ;
