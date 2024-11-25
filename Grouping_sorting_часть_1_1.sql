select users.city, users.age, count(*) FROM users
group BY users.city, users.age
ORDER BY count(*), users.city;   

-- производится группировка по городу и возрасту 
