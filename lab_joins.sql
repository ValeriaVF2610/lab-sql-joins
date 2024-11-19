USE sakila;

-- List the number of films per category.
SELECT 
name AS category,
COUNT(film_id) AS film_count
FROM film_category
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- Retrieve the store ID, city, and country for each store.
SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- Calculate the total revenue generated by each store in dollars.

SELECT 
store.store_id,
SUM(payment.amount) AS total_revenue
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN store ON inventory.store_id = store.store_id
GROUP BY store_id;

-- Determine the average running time of films for each category.
SELECT 
category.name AS category,
ROUND(AVG(film.length),2) AS avg_running_time
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name;

-- Identify the film categories with the longest average running time.
SELECT 
category.name AS category,
ROUND(AVG(film.length),2) AS avg_running_time
FROM film 
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY avg_running_time DESC
LIMIT 5;

-- Display the top 10 most frequently rented movies in descending order.
SELECT
film.title,
COUNT(rental.rental_id) AS times_rented
FROM rental
JOIN inventory ON inventory.inventory_id = rental.inventory_id
JOIN film ON film.film_id = inventory.film_id
GROUP BY film.title
ORDER BY times_rented DESC
LIMIT 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT CASE 
    WHEN COUNT(inventory.inventory_id) > 0 THEN 'Available'
    ELSE 'Not Available'
END AS availability_status
FROM film
JOIN inventory ON film.film_id = inventory.film_id 
WHERE film.title = 'Academy Dinosaur' AND inventory.store_id = 1;

-- Provide a list of all distinct film titles, along with their availability status in the inventory.

SELECT 
film.title,
CASE 
	WHEN COUNT(inventory.inventory_id) > 0 THEN 'Available'
	ELSE 'NOT available'
END AS availability_status
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id 
GROUP BY film.title;