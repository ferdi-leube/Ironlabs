insert into cars(car_ID, VIN, manufactorer, model, year_creation, color)
Values (0, '3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue'), (1, 'ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red'), (2, 'RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'White'), (3, 'HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Silver'), (4, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gray'), (5, 'DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019, 'Gray')
;
select * from cars;
insert into customers (customer_id, customer_name, phone_number, email,	address, zip_code, country)
values (0, 'Pablo Picasso', '+34 636 17 63 82', Null , 'Paseo de la Chopera, 14', 28045, 'Spain'), (1, 'Abraham Lincoln', '+1 305 907 7086', NULL , '120 SW 8th St', 33130, 'United States'), (2, 'Napoléon Bonaparte', '+33 1 79 75 40 00', NULL , '40 Rue du Colisée', 75008, 'France')
;
insert into salsperson (salesperson_id, salesperson_name, store_location)
values (0, 'Petey Cruiser', 'Madrid'), (1, 'Anna Sthesia', 'Barcelona'), (2, 'Paul Molive', 'Berlin'), (3, 'Gail Forcewind', 'Paris'), (4, 'Paige Turner', 'Mimia'), (5, 'Bob Frapples', 'Mexico City'), (6, 'Walter Melon', 'Amsterdam'), (7, 'Shonda Leer', 'São Paulo')
;
insert into invoices (ID_num, invoice_date, car_ID, customer_id, salesperson_id)
values (852399038, '2018-08-22', 0, 1, 3), (731166526, '2018-12-31', 3, 0, 5), (271135104, '2019-01-22', 2, 2, 7)
;