DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;



DROP TABLE IF EXISTS logg;
DROP TABLE IF EXISTS faktura_rad;
DROP TABLE IF EXISTS faktura;
DROP TABLE IF EXISTS produkt_kategori;
DROP TABLE IF EXISTS kundorder_produkt;
DROP TABLE IF EXISTS kundorder;

DROP TABLE IF EXISTS kategori;
DROP TABLE IF EXISTS produkt;
DROP TABLE IF EXISTS kund;

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
    ordernummer INT,
    kund INT,
    orderdatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    -- uppdaterad funkar endast när vi kör sql men ej i sql-lite?
    -- föreläsning 2017 48:00
    uppdaterad DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    borttagen DATETIME DEFAULT NULL,
    skickad DATETIME DEFAULT NULL,

    PRIMARY KEY (ordernummer),
    FOREIGN KEY (kund) REFERENCES kund(id)
);

CREATE TABLE produkt
(
    produktkod INT,
    produktnamn VARCHAR(20),
    produktbeskrivning VARCHAR(50),
    produktpris INT,

    PRIMARY KEY (produktkod)
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

CREATE TABLE lagerhylla
(
    hylla VARCHAR(20),
    produkt INT,
    antal INT,

    PRIMARY KEY(hylla),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod)
);

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
    -- ha dem som kombinerad primärnyckel?
    PRIMARY KEY (faktura, produkt),
    FOREIGN KEY(produkt) REFERENCES produkt(produktkod),
    FOREIGN KEY(faktura) REFERENCES faktura(fakturanummer)
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
