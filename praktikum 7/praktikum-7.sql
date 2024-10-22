use classicmodels;


-- nomor 1
select productCode, productName, buyPrice
from products
where buyprice > (select avg(buyprice) from products);

	-- inner query
	select avg(buyprice) from products;


-- nomor 2
select orderNumber, orderDate
from orders
join customers c
using (customernumber)
where c.customernumber in (
	select c.customernumber
	from customers c
	join employees e
	on c.salesrepemployeenumber = e.employeenumber
	join offices o
	using (officecode)
	where o.city = 'tokyo');
    
    -- inner query
	select c.customernumber
	from customers c
	join employees e
	on c.salesrepemployeenumber = e.employeenumber
	join offices o
	using (officecode)
	where o.city = 'tokyo';

-- nomor 3    
select c.customerName, o.orderNumber, o.shippedDate, o.requiredDate, group_concat(productName order by od.quantityordered separator ", ") as Product, sum(od.quantityordered) as total_quantity_ordered, concat(e.firstname, ' ', e.lastname) as employeeName
from products p
join orderdetails od
using (productcode)
join orders o
using (ordernumber)
join customers c
using (customernumber)
join employees e
on c.salesrepemployeenumber = e.employeenumber
where o.ordernumber in (select ordernumber
from orders
where shippeddate > requireddate)
group by ordernumber;

	-- inner query
	select ordernumber, shippeddate, requireddate
	from orders
	where shippeddate < requireddate;
 

-- nomor 4
select productName, productLine, sum(od.quantityordered) as total_quantity_ordered
from products p
join orderdetails od
using (productcode)
where p.productline in (
	select p.productline
	from ( select p.productline
			from products p
            join orderdetails od
            using (productcode)
            group by p.productline
            order by sum(od.quantityordered) desc	
            limit 3
            ) as top_productline
            )
group by p.productname, p.productline
order by total_quantity_ordered desc;

select p.productName, p.productLine, sum(od.quantityOrdered) as total_quantity_ordered
from products p
join orderdetails od 
using (productCode)
where p.productLine IN (
	select productLine
	from (select p.productLine
			from products p
            join orderdetails od
            using (productCode)
            group by p.productLine
            order by sum(od.quantityOrdered) desc
            limit 3
        ) as top_productline
    )
group by p.productCode
order by productline, total_quantity_ordered desc;




-- inner query
select p.productline
from products p
join orderdetails od
using (productcode)
group by productline
order by sum(od.quantityordered) desc
limit 3;

select productName, productLine, sum(od.quantityordered) as total_quantity_ordered
from products p
join orderdetails od
using (productcode)
where p.productline in (
	select p.productline
from products p
join orderdetails od
using (productcode)
group by productline
order by sum(od.quantityordered) desc
limit 3)
group by p.productname, p.productline
order by total_quantity_ordered desc;

-- soal tambahan
select sum(od.priceeach * od.quantityordered) as 'total harga semua pesanan', year(o.orderdate) as tahun
from orders o
join orderdetails od
using (ordernumber)
join products p
using (productcode)
group by tahun
having tahun = (
				select year(orderdate) as tahun
				from orders o
				join orderdetails od
				using (ordernumber)
				group by tahun
				order by od.quantityordered
				limit 1
			);

			-- inner query
			select year(orderdate) as tahun
			from orders o
			join orderdetails od
			using (ordernumber)
			group by tahun
			order by od.quantityordered
			limit 1;
