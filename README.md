# Skapa ER-modell för en databas (logisk/fysisk)

## Krav
Läs igenom samtliga krav innan du börjar jobba.

- Bygg vidare på din konceptuella modell som du dokumenterat i ett befintligt dokument. [x]

- Skapa en ny sida med rubrik “Logisk modell” och utför och dokumentera alla delsteg för den logiska modelleringsfasen, enligt kokboken. [x]

- Skapa en ny sida med rubrik “Fysisk modell” och utför och dokumentera alla delsteg för den fysiska modelleringsfasen. Du skall skapa SQL DDL men du skall inte skapa INSERT, UPDATE, DELETE eller SELECT. [x]

- Berätta i dokumentet hur du gjorde för att skapa SQL DDL (per hand eller genererade). SQL DDL lägger du som ett Appendix i ditt dokument, för information, använd ett rimligt typsnitt. [/]

- Din SQL DDL sparar du även som egen fil i ddl.sql. Denna filen skall innehålla SQL för att skapa databasens schema. [/]

- Skapa en fil setup.sql som skapar databasen eshop (CREATE DATABASE). [/]

- Försäkra dig om att din SQL DDL (setup.sql, ddl.sql) fungerar och skapar den databasen och de tabellerna du vill ha. Du behöver inte lägga in någon data i tabellerna, eller provköra databasen, det gör vi senare. [x]

- Spara ditt orginal dokument i katalogen du jobbar. Generera även en PDF som er.pdf. [/]

- Tips. Skapa även en reset.sql så du snabbt och enkelt kan återskapa och återställa din databas. []

När du är klar så publicerar du ditt kursrepo. []

# Ställ dig i kurskatalogen
```
dbwebb publish me

dbwebb test er2
```