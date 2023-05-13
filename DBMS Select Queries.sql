/*
 * Project: ICS-311 DBMS Partner Project -- step 3
 * FILE: DBMS Project Query Step3.sql
 * BY: Christopher Simmerman and Jemina Maaisn
*/

/*
1. This query selects all products in our inventory and lists them in descending order 
by quantity. The query also lists the product model and brand names by using a 
join statement to join the inventory and product tables. 
*/
SELECT inventory.prod_id, inventory.quantity, product.model, product.brand
FROM inventory
JOIN product ON inventory.prod_id = product.prod_id
ORDER BY inventory.quantity DESC;


/*
2. This query lists all the employees that have made orders, lists the number of orders 
for each employee and the total amount from their orders. 
The JOIN statement matches employees with their orders, 
the COUNT function counts the number of orders made by each employee, 
the SUM function calculates the total sales amount for each employee, 
and the GROUP BY statement groups the results by employee_id.
*/
SELECT e.emp_fname, e.emp_lname, COUNT(o.order_num) AS order_count, SUM(o.selling_price)
FROM employee e
JOIN orders o ON e.emp_id = o.emp_id
GROUP BY e.emp_id;



/*
3. This query creates a view that lists all orders with their customers and employees 
residing in the state of MN, as well as other relevant columns. 
INNER JOINS are used to combine the relevant tables into one. 
Our business could use this query to gauge how active we are in MN.
*/
CREATE VIEW mn_view AS
SELECT c.cus_num, 
c.cus_fname, 
c.cus_lname, 
c.address AS cus_address, 
c.city AS cus_city, 
e.emp_id, 
e.emp_fname, 
e.emp_lname, 
e.address AS emp_address, 
e.city AS emp_city, 
o.order_num, 
o.order_date, 
o.order_amount, 
o.selling_price, 
o.payment_type, 
o.promo_code, 
o.promo_amount, 
s.store_id, 
s.address AS store_address, 
s.city AS store_city
FROM customer c
INNER JOIN orders o ON c.cus_num = o.cus_num AND c.state = 'MN'
INNER JOIN employee e ON o.emp_id = e.emp_id AND e.state = 'MN'
INNER JOIN store s ON o.store_id = s.store_id AND s.state = 'MN';



/*
4. This query selects all tuples from the mn_view view where the store_city of 
each tuple is St. Paul. We could use this query to evaluate store activity 
in our St. Paul location.
*/
SELECT *
FROM mn_view
WHERE store_city = 'St. Paul';

/*
5. This query selects all the promo codes that have been used in all orders, 
as well as their amounts and names. We could use this query to see what our 
most popular promo codes are.
*/
SELECT o.promo_code, o.promo_amount, p.promo_name
FROM orders o
JOIN promotion p ON o.promo_code = p.promo_code;

/*
6. This query returns all motherboards, sorted by ascending price. 
This query could be used to assist a customer who is looking to purchase a motherboard.
*/
SELECT *
FROM product
WHERE prod_desc = 'Motherboard'
ORDER BY price ASC;

/*
7. This query returns the total amount of orders and total order amounts for each type of payment. 
The ‘GROUP BY’ clause groups the results by payment type, so that the sums are 
calculated for each payment type separately. We could use this query to see 
which payment methods are most common in our stores.
*/
SELECT 
    payment_type, 
    SUM(order_amount) as total_order_amount, 
    SUM(selling_price) as total_selling_price
FROM orders
WHERE payment_type IN ('CASH', 'VISA', 'MASTERCARD')
GROUP BY payment_type;

/*
8. This query returns a single row with two columns. 
The total_orders column represents the number of orders in 2023, 
while the total_order_amount column represents the total amount of those orders.
*/
SELECT COUNT(*) as total_orders, SUM(order_amount) as total_order_amount
FROM orders
WHERE order_date LIKE '%2023%';

/*
9. This query returns all the products purchased by the customer with id 11100011. 
We join the orderlinedetail table with the product table to match product IDs 
for each order, as well as the orders table with the orderlinedetail table to 
match order_numbers.
*/
SELECT DISTINCT p.brand, p.prod_desc, p.model
FROM product p
JOIN orderlinedetail old ON old.prod_id = p.prod_id
JOIN orders o ON o.order_num = old.order_num
WHERE o.cus_num = 11100011;

/*
10. This query lists the total profit of April 2023 sales. 
It joins the orders, orderlinedetail, and product tables together to match the 
relevant columns, and then calculates the total profit for all orders made in 
April 2023. The SUM function is used to calculate the sum of the profit for 
each item in the order.
*/
SELECT SUM((p.price - p.cost) * old.quantity) AS total_profit
FROM orders o
JOIN orderlinedetail old ON o.order_num = old.order_num
JOIN product p ON old.prod_id = p.prod_id
WHERE o.order_date >= '2023-04-01' AND o.order_date < '2023-05-01';

/*
11. This query lists the store information of each store in descending order by each store’s number of sales. 
The query joins the store and orders table based on the store_id column, and then 
groups the results by store ID, address, city, state, and zip code. 
The COUNT function is used to count the number of orders for each store.
*/
SELECT s.store_id, s.address, s.city, s.state, s.zip, COUNT(o.order_amount) AS order_count
FROM store s
JOIN orders o ON s.store_id = o.store_id
GROUP BY s.store_id, s.address, s.city, s.state, s.zip
ORDER BY order_count DESC;

/*
12. This query returns the employees in our stores who are under the age of 18. 
We use the DATEDIFF function to calculate the number of days between the 
current date CURDATE and the emp_dob column for each employee. 
If the result is less than 6570 (18 years in days), then the employee is 
considered a minor and is included in the result set.
*/
SELECT *
FROM employee
WHERE DATEDIFF(CURDATE(), emp_dob) < 6570;
