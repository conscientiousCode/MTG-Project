DROP TABLE HasAttribute;
DROP TABLE InCart;
DROP TABLE InOrder;
DROP TABLE CardAttribute;
DROP TABLE CardProduct;
DROP TABLE ProductOrder;
DROP TABLE Customer;
DROP TABLE Merchant;
DROP TABLE SiteUser;

CREATE TABLE SiteUser(
	suid INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
	email VARCHAR(50) NOT NULL UNIQUE,
	password VARCHAR(30) NOT NULL
)ENGINE=InnoDB;


CREATE TABLE Merchant(
	suid INTEGER PRIMARY KEY,
	merchantname varchar(50) NOT NULL UNIQUE,
	FOREIGN KEY (suid) REFERENCES SiteUser(suid)
		ON DELETE NO ACTION
		ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE Customer(
	custid INTEGER PRIMARY KEY,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(30) NOT NULL,
	address VARCHAR(50) NOT NULL,
	city VARCHAR(20) NOT NULL,
	province CHAR(2) NOT NULL,
	postalcode CHAR(6) NOT NULL,	
	FOREIGN KEY (custid) REFERENCES SiteUser(suid)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB;

CREATE TABLE ProductOrder(
	productorderid INTEGER PRIMARY KEY AUTO_INCREMENT,
	custid INTEGER,
	orderdate DATETIME NOT NULL,
	shipdate DATETIME,
	creditcard CHAR(16) NOT NULL,
	cardexpiry DATE NOT NULL,
	totalcost DECIMAL(11,2) NOT NULL,
	FOREIGN KEY (custid) REFERENCES Customer(custid)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	check (totalcost >= 0)
)ENGINE=InnoDB;

CREATE TABLE CardProduct(
	cardproductid INTEGER PRIMARY KEY AUTO_INCREMENT,
	merchantid INTEGER NOT NULL,
	name VARCHAR(120) NOT NULL,
	image BLOB,
	description VARCHAR(1024),
	price DECIMAL(8,2) NOT NULL,
	inventory INTEGER NOT NULL,
	FOREIGN KEY (merchantid) REFERENCES Merchant(suid)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CHECK (price >=0),
	CHECK (inventory >=0)
)ENGINE=InnoDB;

CREATE TABLE CardAttribute(
	cardattributeid INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(20) NOT NULL UNIQUE,
	description VARCHAR(256)
)ENGINE=InnoDB;

CREATE TABLE InOrder(
	productorderid INTEGER,
	cardproductid INTEGER,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (productorderid, cardproductid),
	FOREIGN KEY (productorderid) REFERENCES ProductOrder(productorderid)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	FOREIGN KEY (cardproductid) REFERENCES CardProduct(cardproductid)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CHECK (quantity > 0)
)ENGINE=InnoDB;

CREATE TABLE InCart(
	suid INTEGER,
	cardproductid INTEGER,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (suid, cardproductid),
	FOREIGN KEY (suid) REFERENCES SiteUser(suid)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (cardproductid) REFERENCES CardProduct(cardproductid)
		ON DELETE NO ACTION
		ON UPDATE CASCADE,
	CHECK (quantity > 0)
)ENGINE=InnoDB;

CREATE TABLE HasAttribute(
	cardattributeid INTEGER,
	cardproductid INTEGER,
	PRIMARY KEY(cardattributeid, cardproductid),
	FOREIGN KEY (cardattributeid) REFERENCES CardAttribute(cardattributeid)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	FOREIGN KEY (cardproductid) REFERENCES CardProduct(cardproductid)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)ENGINE=InnoDB;



INSERT INTO SiteUser (email, password) VALUES ('UBCOCOSC304Customer1@gmail.com', 'agreatpassword');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail2@hoxmail.com', 'fakeEmail2@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail3@hoxmail.com', 'fakeEmail3@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail4@hoxmail.com', 'fakeEmail4@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail5@hoxmail.com', 'fakeEmail5@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail6@hoxmail.com', 'fakeEmail6@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail7@hoxmail.com', 'fakeEmail7@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail8@hoxmail.com', 'fakeEmail8@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail9@hoxmail.com', 'fakeEmail9@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('merchant1@hoxmail.com', 'merchant1@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail11@hoxmail.com', 'fakeEmail11@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail12@hoxmail.com', 'fakeEmail12@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail13@hoxmail.com', 'fakeEmail13@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail14@hoxmail.com', 'fakeEmail14@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail15@hoxmail.com', 'fakeEmail15@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail16@hoxmail.com', 'fakeEmail16@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail17@hoxmail.com', 'fakeEmail17@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail18@hoxmail.com', 'fakeEmail18@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail19@hoxmail.com', 'fakeEmail19@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail20@hoxmail.com', 'fakeEmail20@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail21@hoxmail.com', 'fakeEmail21@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail22@hoxmail.com', 'fakeEmail22@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail23@hoxmail.com', 'fakeEmail23@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail24@hoxmail.com', 'fakeEmail24@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail25@hoxmail.com', 'fakeEmail25@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail26@hoxmail.com', 'fakeEmail26@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail27@hoxmail.com', 'fakeEmail27@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail28@hoxmail.com', 'fakeEmail28@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail29@hoxmail.com', 'fakeEmail29@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail30@hoxmail.com', 'fakeEmail30@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail31@hoxmail.com', 'fakeEmail31@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail32@hoxmail.com', 'fakeEmail32@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail33@hoxmail.com', 'fakeEmail33@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail34@hoxmail.com', 'fakeEmail34@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail35@hoxmail.com', 'fakeEmail35@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail36@hoxmail.com', 'fakeEmail36@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail37@hoxmail.com', 'fakeEmail37@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail38@hoxmail.com', 'fakeEmail38@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail39@hoxmail.com', 'fakeEmail39@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail40@hoxmail.com', 'fakeEmail40@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail41@hoxmail.com', 'fakeEmail41@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail42@hoxmail.com', 'fakeEmail42@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail43@hoxmail.com', 'fakeEmail43@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail44@hoxmail.com', 'fakeEmail44@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail45@hoxmail.com', 'fakeEmail45@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail46@hoxmail.com', 'fakeEmail46@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail47@hoxmail.com', 'fakeEmail47@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail48@hoxmail.com', 'fakeEmail48@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail49@hoxmail.com', 'fakeEmail49@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('fakeEmail50@hoxmail.com', 'fakeEmail50@hoxmail.com');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (1, 'Customer', 'One', '17 street ave', 'Edmonton', 'BC', 'G7G7G7');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (2, 'Ned', 'Sampson', '5 street ave', 'Calgary', 'AB', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (3, 'Tom', 'Doe', '16 street ave', 'Montreal', 'MB', 'G7G7G7');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (4, 'Samantha', 'Descarte', '16 street ave', 'Calgary', 'ON', 'F6F6F6');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (5, 'Ned', 'Descarte', '13 street ave', 'Montreal', 'ON', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (6, 'Ned', 'Fletcher', '13 street ave', 'Kelowna', 'MB', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (7, 'Ned', 'Tompkins', '16 street ave', 'Montreal', 'MB', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (8, 'Tom', 'Kendrik', '0 street ave', 'Winnipeg', 'SK', 'A1A1A1');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (9, 'George', 'Russel', '2 street ave', 'Kelowna', 'NS', 'I9I9I9');
INSERT INTO Merchant (suid, merchantname) VALUES (10, 'Best Trash Cards');


INSERT INTO CardProduct (merchantid, name, price, inventory) VALUES (10, 'card1', 1, 5);
INSERT INTO CardProduct (merchantid, name, price, inventory) VALUES (10, 'card2', 2, 5);
INSERT INTO CardProduct (merchantid, name, price, inventory) VALUES (10, 'card2', 3, 5);
INSERT INTO CardProduct (merchantid, name, price, inventory) VALUES (10, 'card2', 4, 5);
INSERT INTO CardProduct (merchantid, name, price, inventory) VALUES (10, 'card2', 5, 5);

