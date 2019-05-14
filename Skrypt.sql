USE `classicmodels`;


/*Table structure for table `employees` */

DROP TABLE IF EXISTS `employees`;

CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`),
  KEY `reportsTo` (`reportsTo`),
  KEY `officeCode` (`officeCode`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`reportsTo`) REFERENCES `employees` (`employeeNumber`),
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`officeCode`) REFERENCES `offices` (`officeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `employees` */

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 

(1102,'Kowalski','Jan','x5408','KowalskiJ@nicecars.com','4',1056,'Sale Manager (EMEA)'),

(1143,'Jankowska','Ania','x5428','Jania@nicecars.com','1',1056,'Sales Manager (NA)'),


/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customerNumber` int(11) NOT NULL,
  `customerName` varchar(50) NOT NULL,
  `contactLastName` varchar(50) NOT NULL,
  `contactFirstName` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `postalCode` varchar(15) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `salesRepEmployeeNumber` int(11) DEFAULT NULL,
  `creditLimit` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`customerNumber`),
  KEY `salesRepEmployeeNumber` (`salesRepEmployeeNumber`),
  CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`salesRepEmployeeNumber`) REFERENCES `employees` (`employeeNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customers` */


insert  into `customers`(`customerNumber`,`customerName`,`contactLastName`,`contactFirstName`,`phone`,`addressLine1`,`addressLine2`,`city`,`state`,`postalCode`,`country`,`salesRepEmployeeNumber`,`creditLimit`) values 

(1,'Radosny','Szymkowiak','Andrzej ','999700456','Krzycka 3',NULL,'Wrocław',NULL,'51552','Poland',1102,'21000.00'),

(2,'Przedsiebiorca','Krol','Jan','510658487','Niska 12',NULL,'Warszawa', NULL,'55100','Poland',1102,'71800.00'),

(3,'Wielki D','Wielki','Pieter','965552151','Krolewska 21','pietro 3','Krakow',NULL,'59954','Poland',1143,'117300.00'),



/*Table structure for table `offices` */

DROP TABLE IF EXISTS `offices`;

CREATE TABLE `offices` (
  `officeCode` varchar(10) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addressLine1` varchar(50) NOT NULL,
  `addressLine2` varchar(50) DEFAULT NULL,
  `country` varchar(50) NOT NULL,
  `postalCode` varchar(15) NOT NULL,
  `voivodeship` varchar(10) NOT NULL,
  PRIMARY KEY (`officeCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `offices` */

insert  into `offices`(`officeCode`,`city`,`phone`,`addressLine1`,`addressLine2`,,`country`,`postalCode`,`voivodeship`) values 

('110','Warszawa','+48 692 219 478','Mirosławska 2','Miła 5','Polska','95-100','Lodzkie'),

/*Table structure for table `orderdetails` */

DROP TABLE IF EXISTS `orderdetails`;

CREATE TABLE `orderdetails` (
  `orderNumber` int(11) NOT NULL,
  `productCode` varchar(15) NOT NULL,
  `quantityOrdered` int(11) NOT NULL,
  `priceEach` decimal(10,2) NOT NULL,
  `orderLineNumber` smallint(6) NOT NULL,
  PRIMARY KEY (`orderNumber`,`productCode`),
  KEY `productCode` (`productCode`),
  CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`orderNumber`) REFERENCES `orders` (`orderNumber`),
  CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`productCode`) REFERENCES `products` (`productCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `orderdetails` */

insert  into `orderdetails`(`orderNumber`,`productCode`,`quantityOrdered`,`priceEach`,`orderLineNumber`) values 

(10100,'S10_4757',3,'39.00',3),

(10100,'S10_1678',5,'5.20',2),

(10101,'S10_4757',2,'39.00',4),

(10101,'S10_4698',1,'14.90',1),

(10102,'S10_4757',2,'39.00',4),

(10102,'S10_1678',1,'5.20',1),

/*Table structure for table `orders` */

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `orderNumber` int(11) NOT NULL,
  `orderDate` date NOT NULL,
  `requiredDate` date NOT NULL,
  `shippedDate` date DEFAULT NULL,
  `status` varchar(15) NOT NULL,
  `comments` text,
  `customerNumber` int(11) NOT NULL,
  PRIMARY KEY (`orderNumber`),
  KEY `customerNumber` (`customerNumber`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `orders` */

insert  into `orders`(`orderNumber`,`orderDate`,`requiredDate`,`shippedDate`,`status`,`comments`,`customerNumber`) values 

(10100,'2019-04-11','2019-04-13','2019-04-12','Shipped',NULL,1),

(10101,'2019-04-10','2019-04-12','2019-04-11','Shipped',NULL,2),

(10102,'2019-04-09','2019-04-11','2019-04-10','Shipped',NULL,3),



/*Table structure for table `payments` */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `customerNumber` int(11) NOT NULL,
  `checkNumber` varchar(50) NOT NULL,
  `paymentDate` date NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`customerNumber`,`checkNumber`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`customerNumber`) REFERENCES `customers` (`customerNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `payments` */

insert  into `payments`(`customerNumber`,`checkNumber`,`paymentDate`,`amount`) values 


(1,'JM555205','2019-04-13','127.4'),

(2,'OM314933','2019-04-12','92.9'),

(3,'BO864823','2019-04-11','161.2'),


/*Table structure for table `productlines` */

DROP TABLE IF EXISTS `productlines`;

CREATE TABLE `productlines` (
  `productLine` varchar(50) NOT NULL,
  `textDescription` varchar(4000) DEFAULT NULL,
  `htmlDescription` mediumtext,
  `image` mediumblob,
  PRIMARY KEY (`productLine`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `productlines` */

insert  into `productlines`(`productLine`,`textDescription`,`htmlDescription`,`image`) values 

('Pielegnacja lakieru samochodowego','Pielęgnacja lakieru samochodowego obejmuje wszystkie prace związane z nim. Rozpoczynając od usunięcia trudnych zabrudzeń takich jak zanieczyszczenia metaliczne, smoła, owady. Przechodząc przez korektę lakieru, a kończąc na zabezpieczeniu lakieru quick detailerem, woskiem, sealantem lub powłoką. W naszej ofercie posiadamy wszystkie konieczne środki do konserwacji lakieru samochodowego.',NULL,NULL),

('Pielegnacja felg i opon','Opony i felgi to elementy szczególnie podatne na zabrudzenia, dlatego niezmiernie ważne jest używanie odpowiednich kosmetyków do opon i felg samochodowych. Kosmetyki do opon i felg samochodowych powinny poradzić sobie z brudem i zanieczyszczeniami, oraz powinny zabezpieczać powierzchnię przed jego osadzeniem. Do podstawowych kosmetyków w tej grupie produktów zalicza się preparaty do czyszczenia felg z osadów asfaltowych i smoły, oraz preparaty usuwające naloty z tarcz i klocków hamulcowych czyli popularne produkty typu „krwawiąca felga”. Oprócz kosmetyków, które usuwają brud i zanieczyszczenia warto zwrócić uwagę na preparaty, które zabezpieczają felgi przed jego osadzanie a są to woski do felg oraz sealanty do felg samochodowych które posiadają podwyższoną odporności na wysokie temperatury. Jeśli myślimy o długotrwałym i najefektywniejszym zabezpieczeniu felg aluminiowych warto pamiętać o powłokach np. ceramicznych.',NULL,NULL),

('Pielegnacja metalu','Aluminium, stal, powierzchnie chromowane… Dość często spotykamy się z takimi materiałami w konstrukcji naszych samochodów. Niestety są one podatne na niszczycielskie działanie warunków atmosferycznych, temperatury, czy uszkodzenia mechaniczne. Jak utrzymać elementy metalowe w najlepszej kondycji przez długie lata? Odpowiednie oczyszczanie, polerowanie i konserwacja metalu to podstawowe działania, które możemy przeprowadzić we własnym garażu! Wystarczy wykorzystać odpowiednie środki chemiczne i akcesoria które znajdziecie w tej sekcji!',NULL,NULL),

('Pielegnacja komory silnika','Olej, płyn chłodniczy, płyn hamulcowy, kurz, błoto… To dość silni przeciwnicy detailera. Pozbędziesz się ich korzystając z wysokiej jakości preparatów do mycia komory silnika. Zapewnią one nie tylko maksymalną skuteczność czyszczenia, ale też odpowiednie zabezpieczenie elementów silnika przed uszkodzeniami chemicznymi i w pewnym stopniu również mechanicznymi. Oczyść swój silnik już dziś!',NULL,NULL),

('Pielegnacja dachow cabrio','Samochody ze składanym dachem, szczególnie materiałowym, to prawdziwe ikony stylu, elegancji, a nierzadko również sportowego charakteru. Miękkie dachy wymagają szczególnej troski, a ich pielęgnacja gwarantuje trwałość i długoletnią odporność na trudne warunki pogodowe. Aby zapewnić dachowi naszego kabrioletu, lub roadstera, najwyższą ochronę, należy użyć wysokiej jakości kosmetyków i preparatów do impregnacji. Wszystkie potrzebne środki chemiczne znajdziecie w tej sekcji naszego sklepu!',NULL,NULL),

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL,
  `MSRP` decimal(10,2) NOT NULL,
  PRIMARY KEY (`productCode`),
  KEY `productLine` (`productLine`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`productLine`) REFERENCES `productlines` (`productLine`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `products` */

insert  into `products`(`productCode`,`productName`,`productLine`,`productVendor`,`productDescription`,`quantityInStock`,`buyPrice`,`MSRP`) values 

('S10_1678','Mikrofibra 40x40cm','Pielegnacja lakieru samochodowego','AutoDet','Wysokiej jakości mikrofibra o bardzo delikatnej strukturze.Świetnie nadaje się do: polerowania wosków, docierania quick detailerów, ścierania past polerskich, ogólnych prac czyszczących',7933,'1.45','5.20'),

('S10_1949','ADBL Vampire Liquid 1L','Pielegnacja felg i opon','ADBL',' środek do usuwania zanieczyszczeń metalicznych z felg i lakieru.',7305,'22.96','39.99'),

('S10_2016','TUGA Alu Teufel żel do felg','Pielegnacja felg i opon ','TUGA','Żel ALU TEUFEL SPECIAL przeznaczony jest głównie do felg aluminiowych polerowanych, chromowych, malowanych, wieloczęściowych - skręcanych. Ze względu na swoją bezkwasową strukturę produkt jest bardzo bezpieczny i nie jest w stanie zniszczyć powłoki zewnętrznej czyszczonej felgi, kołpaka. Nadaje się idealnie do regularnej pielęgnacji.',6625,'19.99','39'),

('S10_4698','Autosol Metal Polish 75ml','Pielegnacja metalu','Autosol','Jeden z najbardziej znanych produktów firmy AUTOSOL. Doskonale czyści, poleruje, oraz chroni. Pozwala w bezpieczny i szybki sposób usunąć utlenienia, lotną rdzę oraz przebarwienia z elementów metalowych. Przywraca polerowanym elementom ich oryginalny, lustrzany połysk. Nadaje niezwykły blask oraz zapewnia długotrwałą ochronę przed warunkami atmosferycznymi. Można stosować na wszystkie metalowe części: jasne metale, chrom, mosiądz, miedź, nikiel, stal nierdzewna, etc. Niezawodna i łatwa w użyciu. Wystarczy nanieść i rozpracować mikrofibrą. Na koniec przetrzeć do sucha.
Do zastosowania przy: samochodach, ciężarówkach, motocyklach, rowerach, lampach, instrumentach muzycznych, zegarkach, świecznikach, metalowych częściach mebli, etc',5582,'5.54','14.90'),

('S10_4757','Mothers Mag and Aluminimum Polish 141g ','Pielegnacja metalu','Mothers Mag',','Legendarna pasta do metalu Mothers. Wystarczająco mocna aby przywrócić blask nawet najbardziej zniszczonym metalowym powierzchniom. Niemniej jednak jest na tyle nieinwazyjna dla czyszczonych powierzchni, że może być regularnie stosowana. Unikalna formuła łączy właściwości czyszczące, polerujące i pielęgnacyjne, dzięki czemu pasta pełni każdą z owych funkcji. Stosując ją na powierzchniach metalowych, jednocześnie oczyszczamy je z zalegających zanieczyszczeń, polerujemy je, nadając im piękny połysk, a także odżywiamy i konserwujemy, aby utrzymały blask na długi czas. Pasta Mag&Aluminium jest więc kompleksowym preparatem do renowacji powierzchni metalowych, odpowiednim dla każdego użytownika. ',3252,'19.85','39.00'),

('S10_4962','Polytop Motor Top Finish 500ml','Pielegnacja komory silnika','Polytop','Preparat do zabezpieczenia i konserwacji silników oraz nadkoli. Preparat aplikujemy po myciu, na mokrą powierzchnię, a następnie pozostawiamy do wyschnięcia. Dobór składników chemicznych pozwolił na to, aby praca przy zabezpieczeniu silnika była jeszcze szybsza, a efekt końcowy na najwyższym poziomie. W przeciwieństwie do tradycyjnych dressingów do plastików w komorze silnika, Top Finish jest antystatyczny.
 ',6791,'39.99','69'),

('S12_1099','Polytop Viskose 1L','Pielegnacja komory silnika','Polytop','Polytop Motorreiniger Viskoze to gotowy środek czyszczący z bardzo dobrym własciwościami myjącymi, a dzięki dodatkowi wiskozy posiada lepką konsystencję.Swoją skuteczność zawdzięcza specjalnemu połączenie aktywnych składników. Niepieniący, gęsty i bardzo skuteczny preparat, który poradzi sobie nawet w przypadku silengo zanieczyszczenia brudem, i wszelkimi innymi zanieczyszczeniami mineralnymi, zwierzęcymi, jak również olejami czy smarami. Nie pozostawia nalotów na gumowych i aluminiowych częściach silnika',68,'45.99','99.99'),

