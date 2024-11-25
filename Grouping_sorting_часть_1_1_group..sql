select users.city, 
case 
when users.age BETWEEN 0 and 20 then 'young'
when users.age BETWEEN 21 and 49 then 'adult'
when users.age >= 50 then 'old'
End as age, 
count(*) FROM users
group BY users.city, 
         CASE 
             WHEN users.age BETWEEN 0 AND 20 THEN 'young'
             WHEN users.age BETWEEN 21 AND 49 THEN 'adult'
             WHEN users.age >= 50 THEN 'old'
         END
ORDER BY count(*), users.city;   

-- группировка по городу и возрастному интервалу 
