drop database if exists skodatabas;
create database skodatabas;
use skodatabas;


create table category
(id int not null auto_increment primary key,
name varchar(50) not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);


create table brand
(id int not null auto_increment primary key,
name varchar(50) not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);


create table rating
(id int not null auto_increment primary key,
name varchar(50) not null,
number int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);


create table address
(id int not null auto_increment primary key,
street varchar(50) not null,
zipCode int not null,
state varchar(50) not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);


create table customer
(id int not null auto_increment primary key,
name varchar(50) not null,
addressId int,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key(addressId) references address(id));


create table product
(id int not null auto_increment primary key,
euSizing int not null,
colour varchar(50) not null,
price double not null,
brandId int,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key(brandId) references brand(id) on delete set null on update cascade);


create table categoryBelonging
(id int not null auto_increment primary key,
productId int not null,
categoryId int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key (productId) references product(id),
foreign key (categoryId) references category(id));


create table orders
(id int not null auto_increment primary key,
dateOfOrder date not null,
orderNumber int not null,
customerId int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key (customerId) references customer(id));



create table review
(id int not null auto_increment primary key,
text varchar(3000),
ratingId int not null,
productId int not null,
ordersId int not null,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key (ratingId) references rating(id) on delete cascade,
foreign key (productId) references product(id),
foreign key (ordersId) references orders(id));


create table cart
(id int not null auto_increment primary key,
ordersId int, 
productId int,
created timestamp default CURRENT_TIMESTAMP,
lastUpdated timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
foreign key (ordersId) references orders(id),
foreign key (productId) references product(id));


set SQL_SAFE_UPDATES = 0;


-- -------------------------------------------


insert into brand (name) VALUES 
('Ecco'), ('Vagabond'), ('Reebok'), ('Pomar'); 

insert into category(name) VALUES 
('Sommarsko'), ('Vintersko'), ('Sportsko'), ('Finsko'), ('Promenadsko');

insert into address (street, zipCode, state) VALUES ('Stenvägen 3', 11233, 'Hägersten'), ('Väggatan 10', 16355, 'Sundbyberg'), 
('Dialoggränd 23', 11267, 'Hägersten'), ('Malmövägen 14', 12156, 'Johanneshov'), ('Storgatan 31', 15144, 'Sundbyberg'), ('Kvartersgatan 58', 16565, 'Vällingby');

insert into product(euSizing, colour, price, brandId) VALUES 
(38, 'svart', 800, 1), (39, 'blå', 800, 1), (40, 'brun', 1000, 2), (37, 'svart', 1000, 2), (41, 'röd', 800, 3), (38, 'blå', 800, 3), (39, 'svart', 900, 4), (42, 'brun', 1100, 4);

insert into categoryBelonging(productId, categoryId) VALUES 
(1,1), (1,3), (2,3), (2,5), (3,2), (3,5), (4,2), (4,4), (5,3), (5,5), (6,1), (6,3), (7,2), (7,5), (8,2), (8,3);

insert into customer (name, addressId) VALUES ('Anna Svensson', 3), ('Pål Svanström', 1), ('Jakob Berg', 5), 
('Siri Löf', 4), ('Lina Samuelsson', 2), ('Svante Storm', 6);

insert into orders (dateOfOrder, orderNumber, customerId) VALUES 
('2020-12-05', 1251, 1), ('2020-12-05', 1251, 2), ('2021-01-01', 9032, 3), ('2021-01-14', 4523, 4), ('2020-11-20', 9002, 5), ('2021-12-26', 5214, 1), ('2021-01-12', 333, 6);

insert into cart (ordersId, productId) VALUES 
(1, 1), (1,2), (2, 8), (3, 2), (3, 5), (3, 6), (4, 6), (4,3), (5, 1), (5, 8), (6, 7), (7, 2);

insert into rating (name, number) VALUES
('Mycket nöjd', 4), ('Nöjd', 3), ('Ganska nöjd', 2), ('Missnöjd', 1);

insert into review (ratingId, text, productId, ordersId) VALUES
 (1, 'Fin färg!', 2, 1), (3,'Små i storlek', 1, 1),  (2, null, 8, 2), (3, null, 2, 3),(1, 'Sååå fina!', 5, 3), (2, null, 6, 3), (4, 'Fick bara en sko :(', 6, 4), (3, 'Väldigt små i storleken', 3, 4);
