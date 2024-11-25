SELECT salary.first_name, salary.last_name, salary.salary, salary.industry,
FIRST_VALUE(salary.first_name) OVER (PARTITION BY salary.industry ORDER BY salary.salary DESC) AS name_ighest_sal
from salary
ORDER BY salary.industry ASC           

--нахождение человека с максимумальной зарплатой с помощью оконной функции

