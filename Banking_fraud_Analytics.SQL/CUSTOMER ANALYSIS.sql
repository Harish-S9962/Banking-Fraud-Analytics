use fraud;

--Which branch have highest number of customers?--;

SELECT b.branch_id,b.branch_name,COUNT( c.customer_id) AS total_customers
FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_customers DESC
 LIMIT 1;

---How many customers or done KYC---;

SELECT COUNT(DISTINCT customer_id) AS kyc_completed_customers
FROM customers
WHERE kyc_status = 'Verified';

---How many customers have Verified KYC in each branch?---;

SELECT b.branch_id,b.branch_name, COUNT( customer_id) AS completed_kyc_customers
FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
WHERE c.kyc_status = 'Verified'
GROUP BY b.branch_id, b.branch_name
ORDER BY completed_kyc_customers DESC,b.branch_id ASC;

----How many customers have Pending  KYC in each branch?---;

SELECT b.branch_id,b.branch_name,
COUNT(c.customer_id) AS completed_kyc_customers
FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
WHERE c.kyc_status ='Pending'
GROUP BY b.branch_id, b.branch_name
ORDER BY completed_kyc_customers DESC;

---Which branch has the highest number of KYC-Verified customers?--;

SELECT b.branch_id,b.branch_name, COUNT(c.customer_id) AS completed_kyc_customers
FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
WHERE c.kyc_status = 'Verified'
GROUP BY b.branch_id, b.branch_name
ORDER BY completed_kyc_customers DESC
limit 1;

---Which branch has the lowest number of KYC-verified customers?---;

SELECT b.branch_id,b.branch_name, COUNT(c.customer_id) AS completed_kyc_customers
FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
WHERE c.kyc_status = 'Verified'
GROUP BY b.branch_id, b.branch_name
ORDER BY completed_kyc_customers 
limit 1;

---Which branch has the highest KYC completion rate?--;

SELECT b.branch_name, COUNT(CASE WHEN c.kyc_status = 'Verified' THEN 1 END) AS completed_kyc,
COUNT(c.customer_id) AS total_customers,
ROUND(COUNT(CASE WHEN c.kyc_status = 'Verified' THEN 1 END)* 100.0 / COUNT(c.customer_id),2) AS kyc_completion_rate
FROM customers c join branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY kyc_completion_rate DESC
LIMIT 1;

---Show KYC status, total number, branch-wise, verified, pending, rejected?--;

SELECT b.branch_id,b.branch_name,
COUNT(CASE WHEN c.kyc_status = 'Verified' THEN 1 END) AS verified,
COUNT(CASE WHEN c.kyc_status = 'Pending' THEN 1 END) AS pending,
COUNT(CASE WHEN c.kyc_status = 'Rejected' THEN 1 END) AS rejected,
COUNT(c.customer_id) AS total_customers FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY  b.branch_id;


---show total number of customers---;

select count(*)from customers;

---Display gender wise total number of customers---;

SELECT gender, COUNT(*) AS total_customers
FROM customers
GROUP BY gender;

---Which branch have lowest number of customers--;

SELECT b.branch_id,b.branch_name,COUNT(c.customer_id) AS total_customers
FROM customers c JOIN branches b
    ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_customers 
limit 1;

--Display distinct genders--;

select distinct gender from customers;

-- How many male, female, other, and missing-gender customers are there in each branch?--;

SELECT b.branch_id,b.branch_name,
COUNT(CASE WHEN gender = 'Male' THEN 1 END) AS M_gender,
COUNT(CASE WHEN gender = 'Female' THEN 1 END) AS F_gender,
COUNT(CASE WHEN gender = 'Other' THEN 1 END) AS O_gender,
COUNT(CASE WHEN c.gender IS NULL THEN 1 END) AS null_gender
FROM customers c JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY branch_id, b.branch_name;


---Which Customers have truncated phone number--;

SELECT customer_id,phone_number,phone_status
FROM customers
WHERE LENGTH(phone_number) <> 10;

---What is the total number of customers registered each year based on registration date?--;

SELECT YEAR(registration_date) AS registration_year,COUNT(*) AS total_customers
FROM customers
GROUP BY YEAR(registration_date)
ORDER BY registration_year ;

--Display which year had the highest number of customers Registrations.--;

SELECT YEAR(registration_date) AS registration_year,COUNT(*) AS total_customers
FROM customers
GROUP BY YEAR(registration_date)
ORDER BY total_customers desc
LIMIT 1;




