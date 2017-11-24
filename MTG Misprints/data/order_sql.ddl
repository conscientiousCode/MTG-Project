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

