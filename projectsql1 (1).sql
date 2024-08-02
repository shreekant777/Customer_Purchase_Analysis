
use project;

create table customers (CustomerID int primary key,CustomerName varchar(30),Country varchar(30));

create table products (productid int primary key,productname varchar(30), product_Category varchar(100),product_Quantity int);

create table purchase(transactionid int, customerid int,productid int,purchase_price decimal(10,2),purchase_date date,
foreign key (customerid) references customers(customerid),
foreign key( productid) references products(productid));

#CHECK PURCHASE DATA 
select * from purchase;

#CHECK CUSTOMERS DATA
select * from customers;

#CHECK PRODUCTS DATA

select * from products;


#HANDLING MISSING  VALUES
select * from purchse
where customerid not in (select customerid from customers)
or productid not in (select productid from products)
or transactionid not in (select transactionid from purchase);


SET SQL_SAFE_UPDATES=FALSE;

delete from purchase 
where customerid is null
or productid is null
 or purchase_price is null
 or purchase_date is null;
  
  #CREATE RELATIONSHIP
  alter table purchase 
  add  constraint fk_customers
  foreign key (customerid) references customers(customerid);
 
  alter table purchase 
  add constraint fk_products
  foreign key (productid) references products(productid);
  
# TOTAL sales PER CUSTOMERS
select  purchase.customerid,customers.customername,
sum(products.product_quantity) as total_quantity,
sum(purchase.purchase_price*products.product_quantity) as total_sales
from 
purchase
join
customers on purchase.customerid=customers.customerid
join
products on products.productid=purchase.productid 
group by purchase.customerid,customers.customername
limit 0,1000;
   
   
# total sales per product
select purchase.productid,products.productname,
sum(products.product_quantity*purchase.purchase_price) as totalsales
from purchase 
 join products 
 on purchase.productid=products.productid
 group by purchase.productid,products.productname
 limit 0,1000;
   
   
   #sales per country
   SELECT 
    customers.Country, SUM(purchase.Purchase_Price * products.PRODUCT_Quantity) AS TotalSales
FROM 
    Purchase 
JOIN 
    CUSTOMERS  ON purchase.CUSTOMERID = customers.CUSTOMERID
JOIN
	PRODUCTS ON products.PRODUCTID = purchase.PRODUCTID
GROUP BY 
    customers.CountrY
LIMIT 0, 1000;
   
   