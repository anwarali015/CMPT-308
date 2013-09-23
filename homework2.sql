 -- Get the cities of agents booking an order for customers c002
select city 
from agents
	where aid in (select aid 
			from orders
			where cid = 'c002');

-- Get the pids of products ordered through any	agent who makes	at least one order for a customer in Kyoto. (This is not the same as asking for	pids	
-- of products ordered by a customer in	Kyoto.)
select pid 
from products
where pid in (select pid 
		from orders 
		where aid in (select aid 
				from orders
				where cid in (select cid 
						from customers
						where city in ('Kyoto'))));
	
-- Find the cids and names of customers who never placed and order through agent 'a03'
select cid, name 
from customers 
where cid not in (select cid 
			from orders
			where aid = 'a03');


-- Get the cids and names of customers who ordered both products 'p01' and 'p07'
select cid, name 
from customers 
where cid in (select cid from orders where pid = 'p01')
		and cid in
	      (select cid from orders where pid = 'p07');


-- Get the pids	of products ordered by any customers whoever placed an order through agent a03
select pid 
from products
where pid in (select pid 
		from orders
		where aid ='a03');

-- Get the names and discounts of all customers who place orders through agents in 'Dallas' or 'Duluth;
select name, discount  
from customers
where cid in (select cid 
		from orders
		where aid in (select aid 
				from agents
			        where city in ('Dallas', 'Duluth')));
	 
-- Find all customers who have the same discount as that of any customers in Dallas or Kyoto
select * 
from customers
where discount in (select discount 
			from customers group by discount
			having (count (discount) > 1) 
		and discount in
			(select discount 
			from customers
			where city in ('Dallas','Kyoto')));
	
-- Get IDs of customers who did not place an order any order through agent 'a03'
select cid 
from customers 
where cid not in (select cid 
			from orders
			where aid = 'a03');

