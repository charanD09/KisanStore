CREATE TABLE Customer_Info (
   cutomer_Phone varchar(25) NOT NULL,
   customer_id int NOT NULL,
   first_name varchar(25) NOT NULL,
   last_name varchar(25) NOT NULL,
   address varchar(25) NOT NULL,
   zipcode int NOT NULL,
   Product_Info_product_id int NOT NULL,
   order_id int NOT NULL,
   CONSTRAINT Customer_Info_pk PRIMARY KEY (customer_id)
);




CREATE TABLE Product_Info (
   product_name varchar(25) NOT NULL,
   product_id int NOT NULL,
   Cost float(10,7) NOT NULL,
   brand_id int NOT NULL,
   Customer_id int NOT NULL,
   CONSTRAINT Product_Info_pk PRIMARY KEY (product_id)
);


CREATE TABLE Supplier_Info (
   supplier_ID int NOT NULL,
   supplier_Fname varchar(25) NOT NULL,
   supplier_Lname varchar(25) NOT NULL,
   company_name varchar(25) NOT NULL,
   address varchar(25) NOT NULL,
   Product_Info_product_id int NOT NULL,
   CONSTRAINT Supplier_Info_pk PRIMARY KEY (supplier_ID)
);

CREATE TABLE Sales_Info (
   sales_Id int NOT NULL,
   Item_sold varchar(25) NOT NULL,
   date date NOT NULL,
   price float(10,7) NOT NULL,
   profit int NOT NULL,
   Supplier_ID int NOT NULL,
   CONSTRAINT Sales_Info_pk PRIMARY KEY (sales_Id)
);

CREATE TABLE Store_Info (
   store_id int NOT NULL,
   store_name varchar(25) NOT NULL,
   phone varchar(15) NOT NULL,
   email varchar(25) NOT NULL,
   address varchar(50) NOT NULL,
   zipcode varchar(25) NOT NULL,
   sales_Id int NOT NULL,
   Sales_Info_sales_Id int NOT NULL,
   CONSTRAINT Store_Info_pk PRIMARY KEY (store_id)
);


CREATE TABLE Order_Info (
   order_id int NOT NULL,
   cutomer_id int NOT NULL,
   order_status varchar(25) NOT NULL,
   order_date date NOT NULL,
   store_id  int NOT NULL,
   Store_Info_store_id int NOT NULL,
   CONSTRAINT Order_Info_pk PRIMARY KEY (order_id)
);



LOAD DATA LOCAL INFILE 'c:/temp/Customer_Info.csv'
    -> INTO TABLE Customer_Info
    -> FIELDS TERMINATED BY ','
    ->  LINES TERMINATED BY '\r\n'
    -> IGNORE 1 LINES
    -> (cutomer_Phone,customer_id,first_name,last_name,address,zipcode,Product_Info_product_id,order_id);





 LOAD DATA LOCAL INFILE 'c:/temp/Product_Info.csv'
    -> INTO TABLE Product_Info
    ->  FIELDS TERMINATED BY ','
    ->  LINES TERMINATED BY '\r\n'
    -> IGNORE 1 LINES
    -> (product_name,product_id,Cost,brand_id,customer_id);



 LOAD DATA LOCAL INFILE 'c:/temp/Supplier_Info.csv'
    -> INTO TABLE Supplier_Info
    -> FIELDS TERMINATED BY ','
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 LINES
    -> (supplier_ID,supplier_Fname,supplier_Lname,company_name,address,Product_Info_product_id);




LOAD DATA LOCAL INFILE 'c:/temp/Sales_Info.csv'
    -> INTO TABLE Sales_Info
    -> FIELDS TERMINATED BY ','
    ->  LINES TERMINATED BY '\r\n'
    -> IGNORE 1 LINES
    -> (sales_Id,Item_sold, date,price,profit,Supplier_ID);


 LOAD DATA LOCAL INFILE 'c:/temp/Store_Info.csv'
    -> INTO TABLE Store_Info
    -> FIELDS TERMINATED BY ','
    -> LINES TERMINATED BY '\r\n'
    ->  IGNORE 1 LINES
    -> (store_id,store_name,phone,email,address,zipcode,sales_Id,Sales_Info_sales_Id);



LOAD DATA LOCAL INFILE 'c:/temp/Order_Info.csv'
    ->  INTO TABLE Order_Info
    -> FIELDS TERMINATED BY ','
    -> LINES TERMINATED BY '\r\n'
    -> IGNORE 1 LINES
    -> (order_id,cutomer_id,order_status,order_date,store_id,store_info_store_id);



INSERT INTO Order_Info values(405,1005,'delivered','2022-01-01',805,805);

INSERT INTO Store_Info values(805,'hallimi','56763534322','bbb@gmail.com','illinois',78787,505,505);

UPDATE Store_Info SET store_name='newone' WHERE store_id=805; 

Updates the phone and email from 4567143251,aa@gmail.com to  666666666, yyyy@gmail.com  whose store_id=800;

Delete from Customer_Info where customer_id=101;

Delete from store_Info where store_id in (801,802);

Select order_id,order_status from order_info where customer_id=100;

select o.order_id,order_status,customer_id from order_info o join customer_info c where o.cutomer_id=c.customer_id;

select p.product_name,p.product_id,p.brand_id,c.customer_id from product_info p join customer_info c where p.customer_id=c.customer_id;

select  order_id,order_status as STATUS from order_info where order_status='delivered' group by order_id order by order_id desc;

select p.product_name,p.product_id,p.brand_id,c.customer_id,sum(p.cost) from product_info p join customer_info c where p.customer_id=c.customer_id group by c.customer_id having sum(p.cost)>4;

select p.product_name,p.product_id,p.brand_id from product_info p join customer_info c where p.customer_id=c.customer_id group by p.brand_id order by p.brand_id asc;

select c.cutomer_phone,c.zipcode,o.order_status,o.order_date,p.brand_id,p.product_name from customer_info c join order_info o  on c.customer_id=o.cutomer_id join product_info p on o.cutomer_id=p.customer_id order by c.customer_id desc;