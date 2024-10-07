use classicmodels;

-- nomor 1
select distinct c.customername as namaKustomer, p.productname as namaProduk, pl.textdescription as textDescription
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on p.productcode = od.productcode
join productlines pl
on pl.productline = p.productline

where productname like "%titanic%"
order by customername;


-- nomor 2
select c.customerName, p.productName, o.status, o.shippedDate
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on p.productcode = od.productcode

where productname like "%ferrari%" and status = "shipped" and shippeddate between "2003-10-01" and "2004-10-01"
order by shippeddate desc;


-- nomor 3
select ep.firstname as Supervisor, e.firstname as Karyawan
from employees ep
join employees e
on e.reportsto = ep.employeenumber
where ep.firstname like "%gerard%"
order by e.firstname;


-- nomor 4
-- a
select c.customerName, p.paymentDate, e.firstname as employeeName, p.amount
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
join payments p
on p.customernumber = c.customernumber

where paymentdate like "_____11%";

-- b
select c.customerName, p.paymentDate, e.firstname as employeeName, p.amount
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
join payments p
on p.customernumber = c.customernumber

where paymentdate like "_____11%"
order by amount desc
limit 1;

-- c
select c.customerName, p.productName
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on od.productcode = p.productcode
join payments py
on py.customernumber = c.customernumber

where py.paymentdate like "_____11%" and c.customername = "Corporate Gift Ideas Co.";

-- soal tambahan
select c.customerName, e.firstName, p.productName, p.buyPrice, p.MSRP
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on p.productcode = od.productcode

where buyprice < 80/100*msrp;


