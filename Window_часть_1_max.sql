--нахождение человека с максимальной зарплатой с помощью оконной функции

SELECT salary.first_name, salary.last_name, salary.salary, salary.industry,
FIRST_VALUE(salary.first_name) OVER (PARTITION BY salary.industry ORDER BY salary.salary DESC) AS name_ighest_sal
from salary
ORDER BY salary.industry ASC           

--нахождение человека с максимальной зарплатой без оконной функции

select salary.first_name, salary.last_name, salary.salary, salary.industry, table_new.first_name as name_ighest_sal
from 
(SELECT salary.first_name, salary.industry 
FROM salary 
JOIN (
    SELECT industry, MAX(salary) AS max_salary
    FROM salary
    GROUP BY industry
) AS max_salary_per_industry
ON salary.industry = max_salary_per_industry.industry AND salary.salary = max_salary_per_industry.max_salary) as table_new
JOIN
salary
on salary.industry = table_new.industry
order by industry ASC

