create database if not exists car_company;
use car_company;
create table  cars (
car_id int,
VIN varchar(40),
manufactorer varchar(20),
model varchar(20),
year_creation int,
color varchar(20)
);
create table customers (
customer_id int,
customer_name varchar(30),
phone_number varchar(40),
email varchar(39),
address varchar(40),
zip_code int,
country varchar(30)
);
create table salsperson (
salesperson_id int,
salesperson_name varchar(30),
store_location varchar(30)
);
create table invoices (
ID_num int,
invoice_date date,
car_ID int,
customer_id int,
salesperson_id int
);

