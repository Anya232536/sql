SELECT salary.first_name, salary.last_name, salary.salary, salary.industry,
LAST_VALUE(salary.first_name) OVER (PARTITION BY salary.industry 
                                    ORDER BY salary.salary DESC
                                    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS name_ighest_sal
from salary
ORDER BY salary.industry ASC
         
--нахождение человека с минимальной зарплатой с помощью оконной функции

