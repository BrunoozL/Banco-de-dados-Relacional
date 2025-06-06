USE sakila;

SELECT * FROM language;
INSERT INTO language (name) VALUES('portuguese');
SELECT name FROM language WHERE name = 'portuguese';

SELECT * FROM actor;
INSERT INTO actor (first_name, last_name) VALUES ('BRUNO', 'RIGHI');

SELECT * FROM category;
INSERT INTO category (name) VALUES ('Adventure');

SELECT * FROM country;
INSERT INTO country (country) VALUES ('Brasil');

SELECT * FROM city;
INSERT INTO city (city, country_id) VALUES ('Jaú', 110);
SELECT city.city AS 'Cidade', country.country AS 'País' FROM city
	INNER JOIN country ON city.country_id = country.country_id WHERE country = 'Brasil';

SELECT * FROM address;
INSERT INTO address (address, address2, district, city_id, postal_code, phone) VALUES ('7 de Setembro', null, 'Jaú', 601, 17209200, 14999999999);