CREATE TABLE UserType(userid varchar(50) PRIMARY KEY NOT NULL,Usertype varchar(10),Password char(8));

CREATE TABLE User(Email_ID varchar(20) PRIMARY KEY NOT NULL,Name char(50),User_ID varchar(50),FOREIGN KEY(User_ID) REFERENCES UserType(userid));

CREATE TABLE Product(Product_ID varchar(20) PRIMARY KEY NOT NULL,Product_Name varchar(20),Product_Description varchar(50));

CREATE TABLE Colour(Colour_ID varchar(10) PRIMARY KEY NOT NULL,Colour varchar(20));

CREATE TABLE Product_Colour(ProductColour_ID varchar(10) PRIMARY KEY NOT NULL AUTO_INCREMENT,Product_ID varchar(20),Colour_ID varchar(10),Price Integer,FOREIGN KEY(Product_ID) REFERENCES Product(Product_ID),FOREIGN KEY(Colour_ID) REFERENCES Colour(Colour_ID));

CREATE TABLE Customer_ORDER(Order_ID varchar(20) PRIMARY KEY NOT NULL,Email_ID varchar(20),Delivery_Address varchar(50),Total Integer,FOREIGN KEY(Email_ID) REFERENCES User(Email_ID));

CREATE TABLE Product_ORDER(ProductOrder_ID varchar(20) PRIMARY KEY NOT NULL,ProductColour_ID varchar(10),Order_ID varchar(20),Quantity Integer,Total Integer,FOREIGN KEY(ProductColour_ID) REFERENCES Product_Colour(ProductColour_ID),FOREIGN KEY(Order_ID) REFERENCES Customer_ORDER(Order_ID));


INSERT INTO UserType values('C1','Vaibhav','1234567890123');



ALTER TABLE UserType
ADD CONSTRAINT CHK_Password CHECK (Password>8);


ALTER TABLE User MODIFY COLUMN Name char(10);
 
ALTER TABLE User ADD CONSTRAINT CHK_Name CHECK (Name LIKE '[a-zA-Z]%[a-zA-Z]');

INSERT INTO User values('vaibhavtpd@gmail.com','vaibhav123','C1');
