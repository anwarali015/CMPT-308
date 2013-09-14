-- Name : Mohammed Ali
-- Date : 09/16/2013
-- Homework Assignment 1.

-- List all data for all customers --
select * 
from customers;

-- List the name and city of agents named Smith. --
select name, city 
from agents
where name = 'Smith';

-- List pid, name, and quantity of products costing more than US$1.25 --
select pid, name, quantity 
from products 
where priceUSD > 1.25

-- List the ordno and aid of all orders --
select ordno, aid 
from orders;

-- List the names and cities of customers not in Dallas --
select name, city 
from customers
where city <> 'Dallas';
 
-- List	the names of agents in New York	or Newark --
select name 
from agents
where city = 'New York' OR city = 'Newark';

-- List all data for products not in New York or Newark that cost US$1 or less --
select * 
from products 
where  priceUSD <= 1.00 AND city != 'Newark' and city != 'New York';

-- List	all data for orders in January or March --
select *
from orders
where mon = 'jan' or mon = 'mar';

-- List	all data for orders in February	less than US$100 --
select * 
from orders
where mon = 'feb' AND dollars < 100;

-- List	all orders from	the customer whose cid is C005 --
select * 
from orders
where cid = 'c005';