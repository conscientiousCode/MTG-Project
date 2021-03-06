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
	orderdate DATE NOT NULL,
	shipdate DATE,
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
	image MEDIUMBLOB,
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
	custid INTEGER,
	cardproductid INTEGER,
	quantity INTEGER NOT NULL,
	PRIMARY KEY (custid, cardproductid),
	FOREIGN KEY (custid) REFERENCES Customer(custid)
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
INSERT INTO SiteUser (email, password) VALUES ('merchant1@hoxmail.com', 'merchant1@hoxmail.com');
INSERT INTO SiteUser (email, password) VALUES ('merchant2@hoxmail.com', 'merchant2@hoxmail.com');

INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (1, 'Customer', 'One', '17 street ave', 'Edmonton', 'BC', 'G7G7G7');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (2, 'Ned', 'Sampson', '5 street ave', 'Calgary', 'AB', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (3, 'Tom', 'Doe', '16 street ave', 'Montreal', 'MB', 'G7G7G7');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (4, 'Samantha', 'Descarte', '16 street ave', 'Calgary', 'ON', 'F6F6F6');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (5, 'Ned', 'Descarte', '13 street ave', 'Montreal', 'ON', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (6, 'Ned', 'Fletcher', '13 street ave', 'Kelowna', 'MB', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (7, 'Ned', 'Tompkins', '16 street ave', 'Montreal', 'MB', 'H8H8H8');
INSERT INTO Customer (custid, firstname, lastname, address, city, province, postalcode) VALUES (8, 'Tom', 'Kendrik', '0 street ave', 'Winnipeg', 'SK', 'A1A1A1');
INSERT INTO Merchant (suid, merchantname) VALUES (9, 'Best Trash Cards');
INSERT INTO Merchant (suid, merchantname) VALUES (10, 'Worst Top Cards');


INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (10, 'card1', 1, 5, 'first description');
INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (10, 'card2', 2, 5, 'second description');
INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (10, 'card3', 3, 5, 'third description');
INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (10, 'card4', 4, 5, 'fourth description');
INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (10, 'card5', 5, 5, 'fifth description');
INSERT INTO CardProduct (merchantid, name, price, inventory, description) VALUES (10, 'cardWithNoStock', 1, 0, 'first description');

INSERT INTO CardAttribute (name) VALUES ('Artifact');
INSERT INTO CardAttribute (name) VALUES ('Creature');
INSERT INTO CardAttribute (name) VALUES ('Enchantment');
INSERT INTO CardAttribute (name) VALUES ('Instant');
INSERT INTO CardAttribute (name) VALUES ('Legendary');
INSERT INTO CardAttribute (name) VALUES ('Planeswalker');
INSERT INTO CardAttribute (name) VALUES ('Sorcery');
INSERT INTO CardAttribute (name) VALUES ('White');
INSERT INTO CardAttribute (name) VALUES ('Blue');
INSERT INTO CardAttribute (name) VALUES ('Black');
INSERT INTO CardAttribute (name) VALUES ('Red');
INSERT INTO CardAttribute (name) VALUES ('Green');
INSERT INTO CardAttribute (name) VALUES ('Misprint');
INSERT INTO CardAttribute (name) VALUES ('Miscolor');
INSERT INTO CardAttribute (name) VALUES ('Blotched');
INSERT INTO CardAttribute (name) VALUES ('Miscut');
INSERT INTO CardAttribute (name) VALUES ('Wrong Text');
INSERT INTO CardAttribute (name) VALUES ('Wrong Image');
INSERT INTO CardAttribute (name) VALUES ('Foreign Language');
INSERT INTO CardAttribute (name) VALUES ('Signed');
INSERT INTO CardAttribute (name) VALUES ('Damaged');
INSERT INTO CardAttribute (name) VALUES ('Foil');
INSERT INTO CardAttribute (name) VALUES ('Altered');
INSERT INTO CardAttribute (name) VALUES ('Playtest');

INSERT INTO HasAttribute (cardproductid, cardattributeid) VALUES (1,1);
INSERT INTO HasAttribute (cardproductid, cardattributeid) VALUES (1,2);
INSERT INTO HasAttribute (cardproductid, cardattributeid) VALUES (1,3);
INSERT INTO HasAttribute (cardproductid, cardattributeid) VALUES (2,1);
INSERT INTO HasAttribute (cardproductid, cardattributeid) VALUES (2,2);
INSERT INTO HasAttribute (cardproductid, cardattributeid) VALUES (3,1);

INSERT INTO InCart (cardproductid, custid, quantity) VALUES (1, 1, 1);
INSERT INTO InCart (cardproductid, custid, quantity) VALUES (2, 1, 2);
INSERT INTO InCart (cardproductid, custid, quantity) VALUES (3, 1, 3);
INSERT INTO InCart (cardproductid, custid, quantity) VALUES (4, 1, 4);
INSERT INTO InCart (cardproductid, custid, quantity) VALUES (5, 1, 5);

INSERT INTO ProductOrder (custid, orderdate, shipdate, creditcard, cardexpiry, totalcost) VALUES (1, '2017-11-28', '2017-11-29', '1234567890123456', '3000-11-28', 9);
INSERT INTO InOrder (productorderid, cardproductid, quantity) VALUES (1, 4, 1);
INSERT INTO InOrder (productorderid, cardproductid, quantity) VALUES (1, 5, 1);

INSERT INTO ProductOrder (custid, orderdate, shipdate, creditcard, cardexpiry, totalcost) VALUES (1, '2017-11-28', '2017-11-30', '1234567890123456', '3000-11-28', 9);
INSERT INTO InOrder (productorderid, cardproductid, quantity) VALUES (2, 4, 1);
INSERT INTO InOrder (productorderid, cardproductid, quantity) VALUES (2, 5, 1);

INSERT INTO ProductOrder (custid, orderdate, creditcard, cardexpiry, totalcost) VALUES (1, '2017-11-28', '1234567890123456', '3000-11-28', 9);
INSERT INTO InOrder (productorderid, cardproductid, quantity) VALUES (3, 4, 1);
INSERT INTO InOrder (productorderid, cardproductid, quantity) VALUES (3, 5, 1);