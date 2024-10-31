use classicmodels;

-- nomor 1
(select productName, sum(od.priceeach * od.quantityordered) as TotalRevenue, 'pendapatan tertinggi' as Pendapatan
	from products p
	join orderdetails od
	using (productcode)
	join orders o
	using (ordernumber)
where month(o.orderdate) = 9
group by od.productcode
order by TotalRevenue desc
limit 5)
	union 
(select productName, sum(od.priceeach * od.quantityordered) as TotalRevenue, 'pendapatan terendah'
	from products p
	join orderdetails od
	using (productcode)
	join orders o
	using (ordernumber)
where month(o.orderdate) = 9
group by od.productcode
order by TotalRevenue
limit 5);

-- nomor 2
select productName
from products
where productcode not in(
		select distinct productcode
		from orderdetails od
		join orders o
		using (ordernumber)
		where o.customernumber in (
				(select customernumber
				from customers
				join orders o
				using (customernumber)
				group by customernumber
				having count(ordernumber) > 10)
						intersect
				(select distinct customernumber
				from orders o
				join orderdetails od
				using (ordernumber)
				join products p
				using (productcode)
				where p.buyprice > (select avg(buyprice) from products)))
		);
		
        -- inner query
        (select customernumber
		from customers
		join orders o
		using (customernumber)
		group by customernumber
		having count(ordernumber) > 10)
				intersect
		(select distinct customernumber
		from orders o
		join orderdetails od
		using (ordernumber)
		join products p
		using (productcode)
		where p.buyprice > (select avg(buyprice) from products));
        
-- nomor 3
(select customerName
	from customers
	join orders o
	using (customernumber)
	join orderdetails od
	using (ordernumber)
	join products p
	using (productcode)
	join payments pay
	using (customernumber)
where customernumber in (
				select customernumber
				from payments
				group by customernumber
				having sum(amount) > 2*(
						select avg(totalBayar)
						from (select sum(amount) as totalBayar
						from payments p
						group by customernumber) as kolomBayar)) and productline like '%plane%'
group by customernumber
having sum(od.priceeach*od.quantityordered)>20000)
		intersect
(select customerName
	from customers
	join orders o
	using (customernumber)
	join orderdetails od
	using (ordernumber)
	join products p
	using (productcode)
	join payments pay
	using (customernumber)
where customernumber in (
				select customernumber
				from payments
				group by customernumber
				having sum(amount) > 2*(
						select avg(totalBayar)
						from (select sum(amount) as totalBayar
						from payments p
						group by customernumber) as kolomBayar)) and productline like '%trains%'
group by customernumber
having sum(od.priceeach*od.quantityordered)>20000);






(select customerName
	from customers
	join orders o
	using (customernumber)
	join orderdetails od
	using (ordernumber)
	join products p
	using (productcode)
	join payments pay
	using (customernumber)
where customernumber in (
				select customernumber
				from payments
				group by customernumber
				having sum(amount) > 2*(
						select avg(totalBayar)
						from (select sum(amount) as totalBayar
						from payments p
						group by customernumber) as kolomBayar))
group by customernumber)
		intersect
(select customerName
	from customers
	join orders o
	using (customernumber)
	join orderdetails od
	using (ordernumber)
	join products p
	using (productcode)
	join payments pay
	using (customernumber)
where productline like '%planes%' or '%trains%' 
group by customernumber
having sum(od.priceeach*od.quantityordered)>20000);

-- nomor 4
select o.orderdate as 'Tanggal', c.customerNumber, 'Membayar Pesanan dan Memesan Barang' as riwayat
from orders o
join customers c
using (customernumber)
join payments p
on o.orderdate = p.paymentdate
where o.orderdate like '2003-09%'
		union
select orderdate  as 'Tanggal', customernumber, 'Memesan Barang' as riwayat
from orders
where orderdate like '2003-09%' and orderdate not in (select paymentdate from payments)
		union
select paymentdate  as 'Tanggal', customernumber, 'Membayar Pesanan' as riwayat
from payments p
where paymentdate like '2003-09%' and paymentdate not in (select orderdate from orders)
order by Tanggal;




-- Nomor 5
select productcode
from products p
join orderdetails od
using (productcode)
join orders
using (ordernumber)
where buyprice > (
			select avg(p.buyprice)
            from products p
            join orderdetails od
            using (productcode)
            join orders o
            using (ordernumber)
            where o.orderdate between '2001-01-01' and '2004-03-31')
and od.quantityordered > (12*4)
and left(p.productvendor,1) in ('a','i','u','e','o')
	except
select productcode
from products
join orderdetails od
using (productcode)
join orders o
using (ordernumber)
join customers c
using (customernumber)
where c.country in ('japan', 'germany', 'italy')

order by productcode;

