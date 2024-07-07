-- 1. What is the total amount each customer spent on zomato?

SELECT 
    s.userid, 
    SUM(p.price) AS total_amount_spent
FROM 
    sales s
JOIN 
    product p ON s.product_id = p.product_id
GROUP BY 
    s.userid;
    
-- 2. How many days has each costumer visited zomato?

SELECT 
    userid, 
    COUNT(DISTINCT created_date) AS distinct_days
FROM 
    sales
GROUP BY 
    userid;

-- 3. Determine the most purchased item on the menu and the number of times it was purchased by all customers?

SELECT 
    s.product_id,
    p.product_name,
    COUNT(s.product_id) AS purchase_count
FROM 
    sales s
JOIN 
    product p ON s.product_id = p.product_id
GROUP BY 
    s.product_id, p.product_name
ORDER BY 
    purchase_count DESC
LIMIT 1;


-- 4. Which item was the most popular for each customer?

SELECT 
    s.userid,
    s.product_id,
    p.product_name,
    COUNT(s.product_id) AS purchase_count
FROM 
    sales s
JOIN 
    product p ON s.product_id = p.product_id
GROUP BY 
    s.userid, s.product_id, p.product_name
ORDER BY 
    s.userid, purchase_count DESC;
    
-- 5. What is the total orders and amount spent for each member before they become a gold member?

SELECT
    gs.userid,
    COUNT(s.product_id) AS total_orders,
    SUM(p.price) AS total_amount_spent
FROM
    sales s
JOIN
    goldusers_signup gs ON s.userid = gs.userid
JOIN
    product p ON s.product_id = p.product_id
WHERE
    s.created_date < gs.gold_signup_date
GROUP BY
    gs.userid
ORDER BY
    gs.userid;
