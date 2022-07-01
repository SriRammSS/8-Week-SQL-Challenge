alter table runner_ordersc
modify distance decimal (4,2);
alter table runner_ordersc
modify pickup_time datetime;
alter table runner_ordersc
modify duration int;
alter table customer_ordersc
modify  order_time datetime;
alter table pizza_names 
modify pizza_name varchar(12);
alter table pizza_recipes
modify toppings varchar (50);
alter table pizza_toppings 
modify topping_name varchar(15);