-- Write SQL queries to perform the following tasks using the Sakila database:

-- 1. List the number of films per category.

SELECT c.name, COUNT(f.film_id) AS numero_peliculas
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name;

-- 2.Retrieve the store ID, city, and country for each store.
SELECT s.store_id, c.city, co.country
FROM city c
JOIN address a
ON c.city_id = a.city_id
JOIN country co
ON c.country_id = co.country_id
JOIN store s
ON a.address_id = s.address_id;

-- 3.Calculate the total revenue generated by each store in dollars.
SELECT s.store_id, SUM(p.amount)
FROM payment p 
JOIN staff st
ON p.staff_id = st.staff_id
JOIN store s
ON st.store_id = s.store_id
GROUP BY s.store_id;

-- 4. Determine the average running time of films for each category.
SELECT c.name, AVG(length) AS average_running
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running DESC;


-- Bonus:

-- 5 . Identify the film categories with the longest average running time.
SELECT c.name, AVG(length) AS average_running
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY average_running ASC;

-- 6. Display the top 10 most frequently rented movies in descending order.
SELECT f.title, COUNT(i.inventory_id) as film_count
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY film_count DESC
LIMIT 10;

-- 7. Determine if "Academy Dinosaur" can be rented from Store 1.
SELECT
	f.title,
	CASE 
		WHEN r.return_date IS NULL THEN 'Not available'
		ELSE 'Available'
	END AS status_film,
    COUNT(*) AS count_status
FROM film f
JOIN inventory i
ON f.film_id = i.film_id 
JOIN store s
ON i.store_id = s.store_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE title = 'Academy Dinosaur'
GROUP BY status_film;


-- 8. Provide a list of all distinct film titles, along with their availability status in the inventory. 
-- Include a column indicating whether each title is 'Available' or 'NOT available.' 
-- Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."

SELECT
	f.title,
	CASE 
		WHEN r.return_date IS NULL THEN 'Not available'
		ELSE 'Available'
	END AS status_film,
    COUNT(*) AS count_status
FROM film f
JOIN inventory i
ON f.film_id = i.film_id 
JOIN store s
ON i.store_id = s.store_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.title, status_film;