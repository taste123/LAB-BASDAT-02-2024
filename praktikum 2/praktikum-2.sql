use classicmodels;

-- nomor 1
select productcode as "kode produk", productname as "nama produk", quantityinstock as "jumlah stok"
from products
where quantityInStock >= 5000 and quantityInStock <= 6000
order by quantityInStock;

-- nomor 2
select ordernumber as "nomor pesanan", orderdate as "tanggal pesanan", status, customernumber as "nomor pelanggan"
from orders
where status <> "Shipped"
order by customernumber;

-- nomor 3
select employeenumber as "nomor karyawan", firstname, email, jobtitle as "jabatan"
from employees
where jobtitle = "sales rep"
order by firstname
limit 10;

-- nomor 4
select productcode as "nomor produk", productname as "nama produk", productline as "produk lini", buyprice as "harga beli"
from products
order by buyprice desc
limit 5,10;

-- nomor 5
select distinct country, city
from customers
order by country, city;