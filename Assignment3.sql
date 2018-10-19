CREATE TABLE users(
	id int NOT NULL AUTO_INCREMENT,
	user_name char(50) NOT NULL,
	user_email varchar(50) UNIQUE,
	user_password char(8),
	PRIMARY KEY(id)
);

create table user_types(user_type_id int NOT NULL,
type varchar(50),
user_id int,
FOREIGN KEY (user_id) REFERENCES users(id));

create table variants(id int NOT NULL,
color varchar(50),
size varchar(50),
price double,
product_id int,
PRIMARY KEY(id),
FOREIGN KEY (product_id) REFERENCES products(id));

create table products(id int NOT NULL,
name varchar(50),
PRIMARY KEY(id));

create table cart(id int NOT NULL,
product_id int,
variant_id int,
quantity double,
price double,
user_id int,
PRIMARY KEY(id),
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (product_id) REFERENCES products(id),
FOREIGN KEY (variant_id) REFERENCES variants(id));

create table discounts(id int NOT NULL,
discount_type varchar(50),
amount double,
PRIMARY KEY(id));

create table orders(id int NOT NULL,
user_id int,
total double,
delivery_address varchar(60),
discount_id int,
order_date date,
PRIMARY KEY(id),
FOREIGN KEY (discount_id) REFERENCES discounts(id),
FOREIGN KEY (user_id) REFERENCES users(id)
);

create table payment(transaction_id int NOT NULL,
order_id int,
payment_mode varchar(50),
payment_status varchar(50),
transaction_date Date,
PRIMARY KEY(transaction_id),
FOREIGN KEY (order_id) REFERENCES orders(id));




INSERT INTO users Values(10,'vaibhavtpd','vaibhavtapadiya975@gmail.com',7249522167);
INSERT INTO users Values(20,'nikhilgaikwad','nikhil.gaikwad@gmail.com',98810452);
INSERT INTO users Values(30,'kiran','kiran5@gmail.com',4102456);
INSERT INTO users Values(40,'pravesh','praveshm32@gmail.com',5107452);
INSERT INTO users Values(50,'srinivas','sri_1227@gmail.com',28836173);



INSERT INTO user_types values(1,'Inventory Manager',10);
INSERT INTO user_types values(2,'Buyer',40);

INSERT INTO products values(100,'Shirt');
INSERT INTO products values(200,'T shirt');
INSERT INTO products values(300,'Shoes');


INSERT INTO variants values(1000,'Red Shirt','M',500,100);
INSERT INTO variants values(2000,'Black Shirt','L',700,100);
INSERT INTO variants values(3000,'Polo Tshirt','M',350,200);
INSERT INTO variants values(4000,'Blue Shoes','11',820,300);
INSERT INTO variants values(5000,'Sweat Tshirt','XL',330,200);
INSERT INTO variants values(6000,'Brown Shoes','10',550,300);


INSERT INTO discounts values(11,'Flat',200);
INSERT INTO discounts values(21,'Percent',30);


INSERT INTO orders values(60000,10,);


INSERT INTO cart values(10000,100,2000,5,3500,10);
INSERT INTO cart values(20000,200,5000,3,990,10);
INSERT INTO cart values(30000,300,4000,1,820,10);
INSERT INTO cart values(40000,100,1000,6,3000,10);

drop procedure product_order_process;

delimiter //
CREATE procedure  product_order_process()
begin
	INSERT INTO Product_Order(id,product_id,variant_id,quantity,price,user_id) 
	SELECT id,product_id,variant_id,quantity,price,user_id
	FROM cart;

	DELETE FROM cart;
end
//
delimeter ;

drop procedure payment_process;

delimiter //
create procedure payment_process(in t_id int,in o_id int,in pay_mode varchar(10),in pay_status varchar(10),in u_id INT,in address varchar(20),in d_id INT)
begin

DECLARE total int;

    SELECT SUM(price) INTO total FROM cart;
    INSERT INTO orders values(o_id,u_id,total,address,d_id,current_date());
    INSERT INTO payment values(t_id,o_id,pay_mode,pay_status,current_date());
    call product_order_process();
end
//
delimiter ;



call payment_process(100000,1000000,'Debit','Success',10,'Pune',11);


CREATE VIEW view_orders AS SELECT o.id, o.total,p.transaction_date,d.amount,p.payment_mode,p.payment_status 
FROM payment p,orders o,discounts d 
WHERE d.id=o.discount_id and p.order_id=o.id and (order_date>=current_date()-30);






