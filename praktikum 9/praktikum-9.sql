use classicmodels;


create database sepakBola;

-- nomor 1

create table klub(
	id int auto_increment primary key,
    nama_klub varchar(50) not null,
    kota_asal varchar(20) not null
);

create table pemain(
	id int auto_increment primary key,
    nama_pemain varchar(50) not null,
    posisi varchar(20) not null,
    id_klub int,
    foreign key (id_klub) references klub(id)
);

create table pertandingan(
	id int auto_increment primary key,
    id_klub_tuan_rumah int,
    foreign key (id_klub_tuan_rumah) references klub(id),
	id_klub_tamu int,
    foreign key (id_klub_tamu) references klub(id),
    tanggal_pertandingan date not null,
    skor_tuan_rumah int default 0,
    skor_tamu int default 0
);

alter table pemain
add index index_posisi(posisi);

alter table klub
add index index_asal_kota(kota_asal);

describe klub;
describe pemain;
describe pertandingan;

-- nomor 2
select customername, country, sum(p.amount) as totalPayment, count(o.customernumber) as orderCount, max(p.paymentDate) as LastPaymentDate,case
			when sum(p.amount) > 100000 then 'VIP'
            when sum(p.amount) between 5000 and 100000 then 'Loyal'
            else 'New'
            end as Status
from customers c
left join orders o
using (customernumber)
left join payments p
using (customernumber)
group by customerNumber
order by customername;

-- nomor 3
select customernumber, customername, sum(od.quantityordered) as total_quantity,  case
				when sum(quantityordered) > (select avg(totalOrder)
											from (select sum(quantityordered) as totalOrder
												from orderdetails
												join orders
												using (ordernumber)
												join customers
												using (customernumber)
												group by customernumber) as total) then 'di atas rata-rata'
                else 'di bawah rata-rata'
                end as kategori_pembelian
from customers c
join orders o
using (customernumber)
join orderdetails od
using (ordernumber)
group by customernumber
order by total_quantity desc;


select avg(quantityOrdered) from orderdetails;

select avg(totalOrder)
from (select sum(quantityordered) as totalOrder
	from orderdetails
    join orders
    using (ordernumber)
    join customers
    using (customernumber)
    group by customernumber) as total;