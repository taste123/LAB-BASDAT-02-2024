use classicmodels;

-- nomor 1
select customernumber, customername, country, creditlimit
from customers
where (country = 'usa' and creditlimit >  50000 and creditlimit < 100000) or (country <> 'usa' and creditlimit between 100000 and 200000)
order by creditlimit desc;

-- nomor 2
select productcode, productname, quantityinstock, buyprice, productline
from products
where (quantityinstock between 1000 and 2000) and (buyprice <50 or buyprice>150) and productline not like 'vintage%';

-- nomor 3
select productcode, productname, msrp, productline, buyprice
from products
where productline like '%classic%' and buyprice > 50;

-- nomor 4
select ordernumber,orderdate, status, customernumber
from orders
where ordernumber > 10250 and status <> 'shipped' and status <> 'cancelled' and (orderdate like '2004%' or orderdate like '2005%');

-- nomor 5
select ordernumber, orderlinenumber, productcode, quantityordered, priceeach, priceeach - priceeach*(5/100) as 'discountedtotalprice'
from orderdetails
where quantityordered  > 50 and priceeach > 100 and productcode not like 's18%'
order by discountedtotalprice desc;