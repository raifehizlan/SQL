
/*1 What is the sales quantity of product according to the brands 
and sort them highest-lowest*/
SELECT brand_name, p.product_name, COUNT(quantity) as 'quantity of products'
FROM production.brands b, production.products p, sales.order_items o
where b.brand_id = p.brand_id
	and o.product_id=p.product_id
GROUP BY brand_name, p.product_name
order by COUNT(P.product_id) desc

/*2 Select the top 5 most expensive products*/
select top 5 product_name, list_price
from production.products
order by list_price desc

/*3 What are the categories that each brand has*/
select brand_name, category_name
from production.products p, production.brands b, production.categories c
where b.brand_id=p.brand_id and 
	  p.category_id = c.category_id
group by brand_name, category_name
order by brand_name

/*4 Select the avg prices according to brands and categories*/
select brand_name, category_name, avg(p.list_price)
from production.products p, production.brands b, production.categories c
where b.brand_id=p.brand_id and 
	  p.category_id = c.category_id
group by brand_name, category_name
order by brand_name, category_name

/*5 Select the annual amount of product produced according to brands*/
select b.brand_name,p.model_year, count(p.product_id) 'annual amount'
from production.products p, production.brands b
where p.brand_id=b.brand_id
group by b.brand_name,p.model_year
order by brand_name, model_year


/*
6 Select the store which has the most sales quantity in 2016
*/
select top 1 s.store_name, sum(i.quantity)
from sales.stores s
inner join sales.orders o
on s.store_id = o.store_id
inner join sales.order_items i
on o.order_id = i.order_id
where  year(o.order_date) = '2016' 
group by s.store_name
order by sum(i.quantity) desc;

/*7 Select the store which has the most sales amount in 2016*/
select top 1 s.store_name, sum(i.list_price) as amount_sales
from sales.stores s
inner join sales.orders o
on s.store_id = o.store_id
inner join sales.order_items i
on o.order_id = i.order_id
where  year(o.order_date) = '2016' 
group by s.store_name
order by sum(i.list_price) desc;

/*8 Select the personnel which has the most sales amount in 2016*/
select top 1 s.first_name+' '+s.last_name, sum(i.list_price) as amount_sales
from sales.staffs s
inner join sales.orders o
on s.staff_id = o.staff_id
inner join sales.order_items i
on o.order_id = i.order_id
where  year(o.order_date) = '2016' 
group by s.first_name+' '+s.last_name
order by sum(i.list_price) desc;
