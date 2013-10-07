-- Name: Mohammed
-- CMPT - 308
-- SQL Homework Assignment 3

-- 1
--Get the cities of agents booking an order for customer c002. Use a subquery.
--(Yes, this is the same question as on homework #2).
select city
from agents
where aid in (select aid    
		from orders
		where cid = 'c002');

--2
--Get the cities of agents booking an order for customer c002. This time	
--use joins; no subqueries.

select a.city
from agents a
inner join orders o
on o.aid = a.aid
where o.cid = 'c002';

--3
--Get the pids of products ordered through any agent who makes at least	
--one order for a customer in Kyoto. Use subqueries. (Yes, this is also the	
--same question as on homework #2.)
select distinct pid 	
from orders o
where aid in (select aid 
		from orders
		where cid in(select cid 
				from customers
				where city in ('Kyoto'))) order by o.pid;

--4
--Get the pids of products ordered through any agent who makes at least	
--one order for	a customer in Kyoto. Use joins this time; no subqueries

select  distinct o1.pid
from orders o, orders o1, customers c
where o.cid = c.cid
and o1.aid = o.aid
and c.city = 'Kyoto'
order by o1.pid asc 

--5
--Get the names	of customers who have never placed an order. Use a subquery.
select name 
from customers 
where cid not in (select cid 
			from orders);
 
--6
--Get the names	of customers who have never placed an order. Use an outer join. 
select c.name
from customers c
left outer join orders o on
c.cid = o.cid  
where o.cid is null; 

--7
--Get the names	of customers who placed	at least one order through an	
--agent	in their city, along with those	agent(s) names.

select  c.name as "Customer Name", a.name as "Agent Name", a.city as "Agent City"
from  customers c, agents a, orders o
where o.aid = a.aid 
and c.cid = o.cid 
order by c.name;

--8 
--Get the names	of customers and agents	in the same city, along	with the	
--name of the city, regardless of whether or not the customer has ever	
--placed an order with that agent.

select c.name as "Customer Name",  a.name as "Agents Name", c.city as "City"  
from agents a, customers c
where a.city = c.city 
order by "Customer Name" asc;


--9
--Get the name and city	of customers who live in the city where	the least
--number of products are made.


 select name, city from customers c where c.city in( 
select  city from(
(select  p.city, count(p.city) as "citycount"
from products p 
group by p.city 
order by count(p.city)asc limit 1)) sub1 
group by city);




--10
--Get the name and city	of customers who live in a city	where the most
--number of products are made. 

select name, city from customers c where c.city in( 
select  city from(
(select  p.city, count(p.city) as "citycount"
from products p 
group by p.city 
order by count(p.city)desc limit 1)) sub1 
group by city);
 	
--11
--Get the name and city	of customers who live in any city where	the	
--most number of products are made.

 		 
select c.name, c.city 
from customers c 
where c.city in(select city 
		from products 
		group by city 
		having count(city) in(select max("city_count") 
				      from (select p.city, count(p.city) as "city_count"
						from products p
						group by p.city 
						order by count(p.city)desc) sub));




--12
--List the products whose priceUSD is above the	average	priceUSD.
select name, priceUSD
from products
where priceUSD > (select avg(priceUSD)
			from products);

--13	
--Show the customer name, pid ordered, and the dollars for all	customer	
--orders, sorted by dollars from high to low

select  c.name as "Customers Name", o.pid as "Pid Ordered", o.dollars as "Dollars"
from customers c, orders o 
where o.cid = c.cid  
order by dollars desc; 


--14	
--Show all customer names (in order) and their total ordered, and	
--nothing more.	Use coalesce to	avoid showing	NULLs.

select COALESCE (c.name) as "Customer Name", sum(o.qty) as "Total Quantity Ordered"
from orders o, customers c
where c.cid = o.cid   
group by c.name
order by c.name asc;

--15	
--Show the names of all	customers who bought products from agents	
--based	in New York along with the names of the	products they ordered,	
--and the names	of the agents who sold it to them.

select c.name as "Customer Name",  p.name as "Product Purchased", a.name as "Agent Name", a.city as "Agent City"
from orders o, customers c, products p, agents a
where c.cid = o.cid
and o.pid = p.pid 
and a.aid = o.aid
and a.city='New York';

--16	
--Write	a query	to check the accuracy of the dollars column in the 
--Orders table.	This means calculating Orders.dollars from other data in	
--other	tables and then	comparing those	values to the values in	Orders.dollars.

select c.cid, c.name as "Customer_Name",  p.name as "Product_Name", (o.qty * p.priceUSD) as "Before_Discount",
(c.discount) as "Customers_Discount",
(((o.qty*p.priceUSD) -((c.discount)/100) * (o.qty*p.priceUSD))) as "After_Discount"
from orders o, products p, customers c
where p.pid = o.pid  
and o.cid = c.cid 
order by c.name
 
--17	
--Create an error in the dollars column	of the Orders table so that you	
--can verify your accuracy checking query. 

insert into orders values(1111,'jan','c004','a03','p04',9999999,413);










