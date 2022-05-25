select * from customers;
update customers
set email = 'ppicasso@gmail.com'
where customer_name = 'Pablo Picasso'; 

update customers
set email = 'lincoln@us.gov'
where customer_name = 'Abraham Lincoln'; 

update customers
set email = 'hello@napoleon.me'
where customer_name = 'Napoléon Bonaparte'; 
select * from customers;
