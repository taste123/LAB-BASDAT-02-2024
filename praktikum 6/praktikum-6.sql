use classicmodels;

-- nomor 1
select c.customerName, concat(e.firstname, ' ', e.lastname) as salesRep, (c.creditlimit - sum(p.amount)) as remainingCredit
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
join payments p
using (customernumber)
group by customername
having `remainingcredit` > 0;

-- nomor 2
select p.productName, group_concat(distinct c.customerName, ',' order by c.customername) as 'Nama Customer', count(distinct c.customername) as 'Jumlah Customer', sum(quantityordered) as 'Total Quantitas'
from customers c
join orders o
using (customernumber)
join orderdetails od
using (ordernumber)
join products p
using (productcode)
group by p.productname;

-- nomor 3
select concat(e.firstname, ' ', e.lastname) as employeeName, count(c.customerName) as totalCustomers
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
group by `employeeName`
order by `totalCustomers` desc;

-- nomor 4
select concat(e.firstname, ' ', e.lastname) as 'Nama Karyawan', p.productname as 'Nama Produk', sum(od.quantityordered) as 'Jumlah Pesanan'
from employees e
join offices ofc
using (officecode)
left join customers c
on c.salesrepemployeenumber = e.employeenumber
left join orders o
using (customernumber)
left join orderdetails od
using (ordernumber)
left join products p
using(productcode)
where ofc.country = "australia"
group by p.productname, `nama karyawan`
order by `jumlah pesanan` desc;

-- nomor 5
select c.customername as 'Nama Pelanggan', group_concat(p.productname, ',' order by p.productname) as 'Nama Produk', count(distinct p.productcode) as'Banyak Jenis Produk'
from customers c
join orders o
on c.customernumber = o.customernumber
join orderdetails od
on o.ordernumber = od.ordernumber
join products p
on p.productcode = od.productcode
where o.shippeddate is null
group by `nama pelanggan`;

-- soal tambahan
select concat(e.firstname, ' ', e.lastname) as 'Nama Karyawan', group_concat(distinct c.customername, ',') as 'Nama Customer', group_concat(p.productname, ',') as 'produk'
from employees e
left join customers c
on c.salesrepemployeenumber = e.employeenumber
left join orders o
using (customernumber)
left join orderdetails od
using (ordernumber)
left join products p
using (productcode)
group by c.customername;

select c.customername as 'Nama Customer', group_concat(distinct concat(e.firstname, ' ', e.lastname), ', ') as 'Nama Karyawan', group_concat(p.productname, ',') as 'produk'
from customers c
join employees e
on c.salesrepemployeenumber = e.employeenumber
join orders o
using (customernumber)
join orderdetails od
using (ordernumber)
join products p
using (productcode)
group by c.customername;


