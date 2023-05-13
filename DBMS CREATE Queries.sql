/*
 * Project: ICS-311 DBMS Partner Project -- step 2
 * FILE: DBMS Project Query.sql
 * BY: Christopher Simmerman and Jemina Maaisn
 */
 
 -- Create tables
CREATE TABLE `customer`(
	`cus_num` integer,
	`cus_fname` varchar(25) NOT NULL,
    `cus_lname` varchar(25) NOT NULL,
    `address` varchar(150),
    `city` varchar(80),
    `state` varchar(2),
    `country` varchar(3),
	PRIMARY KEY (`cus_num`)
);

CREATE TABLE `product`(
	`prod_id` varchar(8),
    `prod_number` integer NOT NULL,
    `prod_desc` varchar(50),
    `model` varchar(80),
    `brand` varchar(25),
    `cost` numeric(6,2),
    `price` numeric(6,2),
    `msrp` numeric(6,2),
    PRIMARY KEY (`prod_id`)
);

CREATE TABLE `promotion`(
	`promo_code` varchar(20),
    `promo_name` varchar(50),
    `warranty_year` integer,
    PRIMARY KEY(`promo_code`)
);


CREATE TABLE `store`(
	`store_id` varchar(8),
    `address` varchar(150)	 NOT NULL,
    `city` varchar(80) NOT NULL,
    `state` varchar(2) NOT NULL,
    `zip` integer NOT NULL,
    PRIMARY KEY(`store_id`)
);

CREATE TABLE `employee`(
	`emp_id` varchar(8),
    `emp_fname` varchar(25) NOT NULL,
    `emp_lname` varchar(25) NOT NULL,
    `address` varchar(150),
    `city` varchar(80),
    `state` varchar(2),
    `store_id` varchar(8),
    `emp_dob` date NOT NULL,
    PRIMARY KEY (`emp_id`),
    FOREIGN KEY (`store_id`) REFERENCES `Store`(`store_id`)
);

CREATE TABLE `inventory`(
	`inv_id` varchar(8),
    `prod_id` varchar(8),
    `store_id` varchar(8),
    `quantity` integer,
    PRIMARY KEY (`inv_id`),
    FOREIGN KEY (`prod_id`) REFERENCES `Product`(`prod_id`),
    FOREIGN KEY (`store_id`) REFERENCES `Store`(`store_id`)
);

CREATE TABLE `orders`(
	`order_num` integer,
    `cus_num` integer,
    `emp_id` varchar(8),
    `order_date` date,
    `order_amount` integer,
    `selling_price` numeric(6,2),
    `payment_type` varchar(10),
    `store_id` varchar(8),
    `promo_code` varchar(20),
    `promo_amount` integer,
    PRIMARY KEY (`order_num`),
    FOREIGN KEY (`cus_num`) REFERENCES `Customer`(`cus_num`),
    FOREIGN KEY (`store_id`) REFERENCES `Store`(`store_id`),
    FOREIGN KEY (`promo_code`) REFERENCES `Promotion`(`promo_code`)
);

CREATE TABLE `orderlinedetail`(
	`line_num` integer,
    `order_num` integer,
    `prod_id` varchar(8),
    `quantity` integer,
    `price` numeric (8,2),
    PRIMARY KEY (`line_num`),
    FOREIGN KEY (`order_num`) REFERENCES `Orders`(`order_num`),
    FOREIGN KEY (`prod_id`) REFERENCES `Product`(`prod_id`)
);


-- populate tables
INSERT INTO customer(cus_num, cus_fname, cus_lname, address, city, state, country)
	VALUES (11100011, "Jessica", "Andersen", "1234 Duck Street Ln", "Stillwater", "MN", "USA"),
		   (11200022, "Alexander", "Phillion", "4592 Bruce Parkway", "St. Paul", "MN", "USA"),
           (11300033, "Andrew", "Andseren", "1234 Duck Street Ln", "Stillwater", "MN", "USA"),
           (11400044, "James", "Jennings", null, null, null, "USA"),
           (11500055, "Luke", "Zhang", "2816 Easthill", "Menomonie", "WI", "USA"),
           (11600066, "Sarah J", "Connor", "309 Calder Cyn", "Los Angeles", "CA", "USA"),
           (11700077, "Jimmy", "Lancaster", "230 Waters Point Dr", "Des Moines", "IA", "USA"),
           (11800088, "Marty", "McFly", "9303 Roslyndale Avenue", "Hill Valley", "CA", "USA"),
           (11900099, "Muhammad", "Muhammad", null, null, null, "USA"),
           (11000100, "A. J.", "Soprano", "14 Aspen Drive", " North Caldwell", "NJ", "USA")
    ;

INSERT INTO product(prod_id, prod_number, prod_desc, model, brand, cost, price, msrp)
	VALUES ("PRD51331", 250001201, "DDR4 RAM 8GB", "Vengeance LPX", "CORSAIR", 10.00, 20.99, 25.99),
		   ("PRD21221", 121110001, "Laptop", "Aspire 7 w/ Intel Core i5", "LENOVO", 500.00, 649.99, 699.99),
           ("PRD99110", 560021999, "Motherboard", "B550M PRO-VHD WIFI", "MSI", 119.99, 119.99, 119.99),
           ("PRD99221", 560022000, "Motherboard", "ROG STRIX B760-A Gaming WIFI D4", "ASUS", 130.99, 159.99, 159.99),
		   ("PRD88900", 560021999, "CPU", "AMD RYZEN 5 5600X 5000 Series", "AMD", 304.99, 304.99, 304.99),
           ("PRD88800", 687200211, "PSU", "SuperNOVA 650 GT 80 Plus Gold", "EVGA", 119.99, 119.99, 119.99),
           ("PRD40099", 473920009, "Heatsink", "NH-U14S DX-4677", "NOCTUA", 100.99, 120.99, 129.99),
           ("PRD11001", 147023300, "PC Case", "Lancool II Mesh Performance - Black", "LIAN LI", 110.99, 110.99, 129.99),
           ("PRD12020", 147024411, "PC Case", "H5 Elite Tempered Glass ATX Mid-Tower - White", "NZXT", 100.99, 135.99, 145.99),
           ("PRD66701", 638990001, "Keyboard", "APEX 3 TKL Mechanical Gaming Keyboard", "STEELSERIES", 25.00, 45.99, 45.99),
           ("PRD37301", 333566902, "Data Storage", "BarraCuda 4TB 5400 RPM SATA III", "SEAGATE", 67.99, 69.99, 79.99)
    ;

INSERT INTO promotion(promo_code, promo_name, warranty_year)
	VALUES ("10PDC", "10% Discount", null),
		   ("VIPMember", "Members Free shipping", null),
		   ("FREESHIP", "Free Shipping", null),
           ("1WARRANTY", "1 Year Warranty", 1),
           ("2WARRANTY", "2 Year Warranty", 2),
           ("7WARRANTY", "7 Year Warranty", 7),
           ("LTT10OFF", "LinusTechTips Affiliate", null),
           ("GN10OFF","Gamer Nexus Affiliate", null),
           ("10HBD", "Birthday 10% Discount", null),
           ("HBDGIFT", "Birthday Free shipping", null)
    ;

INSERT INTO store(store_id, address, city, state, zip)
	VALUE ("STR11100", "450 Epping Wood Ln", "St. Paul", "MN", 55999),
          ("STR11111", "10014 Delamere Side", "Mahtomedi", "MN", 55139),
          ("STR11122", "933 3rd Ave", "Rochester", "MN", 54693),
          ("STR22202", "203 Shopping Commerce", "Madison", "WI", 45890),
          ("STR22203", "465 W Hamilton Ave", "Eu claire", "WI", 55999),
          ("STR45666", "2485 Airport rd", "Ames", "IA", 55999),
          ("STR64222", "5740 W Cermark", "Rockford", "IL", 55999),
          ("STR78909", "163 E 36th St", "Los Angeles", "CA", 90400),
          ("STR78910", "1274 W Main St", "Alhambra", "CA", 55999),
          ("STR35698", "10 Vincent St", "Verona", "NJ", 55999)
    ;

INSERT INTO employee(emp_id, emp_fname, emp_lname, address, city, state, store_id, emp_dob)
	VALUE ("EMP10010", "Henry", "Norton", "749 W Lakeland Rd", "White Bear Lake", "MN", "STR11111", '2001-02-20'),
		  ("EMP10012", "Matthew", "Gallion", "4568 Hillside St", "Rochester", "MN", "STR11122", '2002-04-17'),
          ("EMP10013", "Monica", "Smith", "11347 E Jordan Ridge", "Minneapolis", "MN", "STR11100", '2003-12-22'),
          ("EMP20014", "James", "Hoff", "2321 Venice St", "West Point", "NY", "STR35698", '1988-04-23'),
          ("EMP30015", "Jacob", "Sletten", "113 SE Beechwater ln", "Hudson", "WI", "STR22203", '1997-10-28'),
          ("EMP30016", "Tyler", "Johnson", "5683 SE Jordan Ridge", "Madison", "WI", "STR22202", '1980-11-01'),
          ("EMP60017", "Jem", "Smith", "3573 Friars Gate", "Des Moines", "IA", "STR45666", '1992-05-05'),
          ("EMP70018", "Johanna", "Zhang", "32 W Framfield Road", "Santa Clarita", "CA", "STR78909", '1989-03-11'),
          ("EMP80019", "Rowan", "Bell-Meyers", "238 Thornwood Ave", "Newton", "IL", "STR64222", '2001-02-20'),
          ("EMP90020", "Mael", "Xiong", "4556 N Maybrook Road", "Lancaster", "CA", "STR78909", '1991-10-27')
    ;

INSERT INTO inventory(inv_id, prod_id, store_id, quantity)
	VALUE ("INV10001", "PRD51331", "STR11100", 30),
		  ("INV10002", "PRD99110", "STR11111", 4),
          ("INV10003", "PRD99221", "STR11122", 6),
          ("INV20001", "PRD37301", "STR22202", 24),
          ("INV20002", "PRD88800", "STR22203", 14),
          ("INV30001", "PRD40099", "STR45666", 8),
          ("INV40001", "PRD11001", "STR78909", 35),
          ("INV40002", "PRD51331", "STR78910", 17),
          ("INV50001", "PRD66701", "STR35698", 10)
    ;

INSERT INTO orders(order_num, cus_num, emp_id, order_date, order_amount, selling_price, payment_type, store_id, promo_code, promo_amount)
	VALUES (1736671001, 11100011, "EMP10012", '2023-04-04', 2, 239.98, "VISA", "STR11122", "LTT10OFF", 10),
		   (1467352022, 11300033, "EMP10012", '2023-04-03', 3, 75.00, "CASH", "STR11122", "10HBD", 10),
           
           (1367353003, 11200022, "EMP10013", '2023-04-04', 1, 500.00, "VISA", "STR11100", null, null),
           
           (1467354004, 11000100, "EMP20014", '2023-02-20', 2, 168.98, "MASTERCARD", "STR35698", null, null),
           
           (1643350055, 11400044, "EMP30015", '2023-01-13', 1, 67.99, "CASH", "STR22203", null, null),
           (1907350099, 11900099, "EMP30015", '2023-02-23', 1, 100.99, "CASH", "STR22203", "10PDC", 10),
           (1300573300, 11500055, "EMP30015", '2023-03-10', 2, 20.00, "VISA", "STR22203", null, null),
           
           (1465740006, 11700077, "EMP60017", '2023-01-23', 1, 130.99, "MASTERCARD", "STR45666", "2WARRANTY", null),
           
           (1767355777, 11800088, "EMP90020", '2023-04-13', 3, 506.97, "MASTERCARD", "STR78909", "VIPMember", null),
           
           (1445786008, 11600066, "EMP70018", '2023-02-03', 2, 135.98, "VISA", "STR78909", "FREESHIP", null)
    ;

INSERT INTO orderlinedetail(line_num, order_num, prod_id, quantity, price)
	VALUES (110000111, 1736671001, "PRD99110", 1, 119.99),
		   (110000112, 1736671001, "PRD88800", 1, 119.99),
           
           (120000111, 1467352022, "PRD66701", 3, 25.00),
           
           (130000111, 1367353003, "PRD21221", 1, 500.00),
           
           (140000111, 1467354004, "PRD40099", 1, 100.99),
           (140000112, 1467354004, "PRD37301", 1, 67.99),
           
           (150000111, 1643350055, "PRD37301", 1, 67.99),
           
           (160000111, 1907350099, "PRD40099", 1, 100.99),
           
           (170000111, 1300573300, "PRD51331", 2, 10.00),
           
           (180000111, 1465740006, "PRD99221", 1, 130.99),
           
           (190000111, 1767355777, "PRD88900", 1, 304.99),
           (190000112, 1767355777, "PRD12020", 1, 100.99),
           (190000113, 1767355777, "PRD40099", 1, 100.99),
           
           (190000211, 1445786008, "PRD37301", 2, 67.99)
    ;

-- additional entries after step 3 (last update: 4/20/2023)
INSERT INTO employee(emp_id, emp_fname, emp_lname, address, city, state, store_id, emp_dob)
	VALUE ("EMP10014", "Teddie", "Holmes", "34647 N Lakeland Rd", "White Bear Lake", "MN", "STR11111", '2007-03-07'),
		  ("EMP10015", "Leila", "James", "1231 Calder St", "Rochester", "MN", "STR11122", '2006-06-6');

INSERT INTO product(prod_id, prod_number, prod_desc, model, brand, cost, price, msrp)
	VALUES ("PRD99111", 560021988, "Motherboard", "WRX80 Creator R2.0 AMD sWRX8 eATX", "ASROCK", 859.99, 899.99, 899.99),
		   ("PRD99112", 560021977, "Motherboard", "B550M Aorus Elite AMD AM4 microATX", "GIGABYTE", 149.99, 149.99, 149.99);