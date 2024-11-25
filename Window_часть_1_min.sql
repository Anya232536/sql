--нахождение человека с минимальной зарплатой с помощью оконной функции

SELECT salary.first_name, salary.last_name, salary.salary, salary.industry,
LAST_VALUE(salary.first_name) OVER (PARTITION BY salary.industry 
                                    ORDER BY salary.salary DESC
                                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS name_ighest_sal
from salary
ORDER BY salary.industry ASC
         
--нахождение человека с минимальной зарплатой без оконной функции

select salary.first_name, salary.last_name, salary.salary, salary.industry, table_new.first_name as name_ighest_sal
from 
(SELECT salary.first_name, salary.industry 
FROM salary 
JOIN (
    SELECT industry, MIN(salary) AS min_salary
    FROM salary
    GROUP BY industry
) AS min_salary_per_industry
ON salary.industry = min_salary_per_industry.industry AND salary.salary = min_salary_per_industry.min_salary) as table_new
JOIN
salary
on salary.industry = table_new.industry
order by industry ASC, salary DESC

