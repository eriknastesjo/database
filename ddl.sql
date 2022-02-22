<<<<<<< HEAD
<<<<<<< HEAD
DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;



=======
DROP DATABASE IF EXISTS eshop;
CREATE DATABASE eshop;
USE eshop;
-- NAMN eshop i kraven!!!

-- klient koppling - db motor
-- undvika problem med svenska tecken
SET NAMES utf8;

=======
>>>>>>> fae62fd (sql updates)
-- UTAN FK sist, MED FK först 
>>>>>>> 8b8a179 (init)
DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS faktura_rad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS produkt_kategori;
DROP TABLE IF EXISTS kundorder_produkt;
DROP TABLE IF EXISTS kundorder;

<<<<<<< HEAD
DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kund;
=======
DROP TABLE IF EXISTS kund;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kategori;
>>>>>>> 8b8a179 (init)


------------------------------------------
-- PRODUKT
-- En produkt kan ha många kategorier, kategorier kan finns i många produkter M:M
-- produkt, kategori, produkt_kategori

CREATE TABLE produkt
(
    produktkod INT AUTO_INCREMENT,
    produktnamn VARCHAR(20),
    produktbeskrivning VARCHAR(50),
    produktpris INT,

    PRIMARY KEY (produktkod)
);

CREATE TABLE kategori
(
    id INT AUTO_INCREMENT,
    firma VARCHAR(20),
    typ VARCHAR(20),

    PRIMARY KEY (id)
);

CREATE TABLE produkt_kategori
(
    produkt INT,
    kategori INT,

    PRIMARY KEY(produkt, kategori),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod),
    FOREIGN KEY(kategori) REFERENCES kategori(id)
);

-----------------------------------------------------------------
-- KUND
-- kund, kundorder, kundorder_rad
-- 

CREATE TABLE kund
(
    id INT,
    fornamn VARCHAR(20),
    efternamn VARCHAR(20),
    adress VARCHAR(20),
    mail VARCHAR(20),
    kreditkort INT NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE kundorder
(
    ordernummer INT AUTO_INCREMENT,
    kund INT,
    orderdatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- uppdaterad funkar endast när vi kör sql men ej i sql-lite?
    -- föreläsning 2017 48:00
    -- borttagen markera som ej aktiv - soft delete
    uppdaterad DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    borttagen DATETIME DEFAULT NULL,
    skickad DATETIME DEFAULT NULL,

    PRIMARY KEY (ordernummer),
    FOREIGN KEY (kund) REFERENCES kund(id)
);

CREATE TABLE kundorder_rad
(
    kundorder INT,
    produkt INT,
    antal INT,
    PRIMARY KEY (kundorder, produkt),
    FOREIGN KEY (kundorder) REFERENCES kundorder(ordernummer),
    FOREIGN KEY (produkt) REFERENCES produkt(produktkod)
);

----------------------------------------------------------------
-- FAKTURA
-- faktura - faktura_rad

CREATE TABLE faktura
(
    fakturanummer INT,
    kundorder INT,
    kund INT,
    fakturadatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    totalpris INT,

    PRIMARY KEY(fakturanummer),
    FOREIGN KEY(kundorder) REFERENCES kundorder(ordernummer),
    FOREIGN KEY(kund) REFERENCES kund(id)
);

CREATE TABLE faktura_rad
(
    faktura INT,
    produkt INT,
    antal INT,

    -- Man kan väl tänka att det finns ett unikt fakturanummer och i fakturan finns
    -- rader där produkten är det som gör raden unik? Därmed kan man kombinera dem och
    -- ha dem som kombinerad primärnyckel? ZOOM 45:20
    PRIMARY KEY (faktura, produkt),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod),
    FOREIGN KEY(faktura) REFERENCES faktura(fakturanummer)
);

---------------------------------------------------------------------------
-- LAGER
-- lagerhylla - logg - stock

CREATE TABLE lagerhylla
(
    hylla INT,
    produkt INT,
    antal INT,

    PRIMARY KEY(hylla),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod)
);

CREATE TABLE stock 
(
    id INT AUTO_INCREMENT,
    produkt_id INT,
    hyll_id INT,
    antal INT,

    PRIMARY KEY (id),
    FOREIGN KEY (produkt_id) REFERENCES produkt(produktkod),
    FOREIGN KEY (hyll_id) REFERENCES lagerhylla(hylla)
);


CREATE TABLE logg
(
    kundorder_ordernummer INT,
    faktura_fakturanummer INT,
    ordersdatum DATE,
    fraktdatum DATE,

    PRIMARY KEY(kundorder_ordernummer, faktura_fakturanummer),
    FOREIGN KEY(kundorder_ordernummer) REFERENCES kundorder(ordernummer),
    FOREIGN KEY(faktura_fakturanummer) REFERENCES faktura(fakturanummer)
);

----------------------
-- VIEWS
--

DROP VIEW IF EXISTS plocklista;

CREATE VIEW plocklista
AS
SELECT 
    ko.ordernummer,
    ko.kund,
    kor.kundorder,
    kor.produkt,
    kor.antal
FROM kundorder as ko
    INNER JOIN kundorder_rad AS kor
        on ko.ordernummer = kor.kundorder
;

SHOW TABLES;

DESCRIBE plocklista;

