---
--- Frida playing around with SQL
---

----------------------------------------------
-- Start with produkt category
-- 

-- empty tables before insert
DELETE FROM kategori;
DELETE FROM produkt;

INSERT INTO kategori
(
    firma,
    typ
)
VALUES 
(
    'Zoega',
    'kaffe'
),
(
    'Gevalia',
    'kaffe'
),
(
    'Rooibos',
    'te'
)
;

INSERT INTO produkt 
(
produktnamn,
produktbeskrivning,
produktpris
) 
VALUES 
(
'Zoega mörk rost',
'Kaffe mörk rostat',
'14'
);

SELECT * FROM produkt;
SELECT * FROM kategori;
