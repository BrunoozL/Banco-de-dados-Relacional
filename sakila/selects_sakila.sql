USE sakila;
SELECT * FROM actor;
SELECT first_name, last_name FROM actor;
SELECT first_name, last_name FROM actor 
	WHERE first_name LIKE 'S%' ORDER BY last_name;

SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;

SELECT city.city AS 'Cidade', country.country AS 'País' FROM city
	INNER JOIN country ON city.country_id = country.country_id WHERE country = 'Brazil' ORDER BY city ASC;
    


SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM film;
SELECT title, length FROM film 
	WHERE length >= 50 AND length <= 100 ORDER BY length;

SELECT * FROM 
	film ORDER BY release_year DESC LIMIT 5;
    
SELECT rating, COUNT(film_id) FROM film GROUP BY rating;

SELECT language_id, COUNT(film_id) FROM film GROUP BY language_id;

SELECT AVG(rental_rate) AS 'Média do Valor de Locação' FROM film;

SELECT rating, AVG(rental_rate) AS 'Média do Valor de Locação' FROM film
GROUP BY rating ORDER BY 2;

SELECT rating AS 'Classificação', AVG(rental_rate) AS 'Valor Médio' FROM film
	WHERE length > 50 OR length < 40
	GROUP BY rating
    ORDER BY 2 DESC
LIMIT 2;

SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_text;
SELECT * FROM inventory;
SELECT * FROM language;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM staff;
SELECT * FROM store;