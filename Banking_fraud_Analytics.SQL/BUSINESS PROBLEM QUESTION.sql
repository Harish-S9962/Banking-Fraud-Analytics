use fraud;

--What is the total number of customers?---;

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM customers;

--What is the overall fraud rate across all transactions?--;

SELECT COUNT(*) AS total_transactions,SUM(is_fraud = 1) AS fraud_transactions,
ROUND(SUM(is_fraud = 1) * 100.0 / COUNT(*),2) AS overall_fraud_rate
FROM transactions;

--Display Branch wise Fraud rate--;

SELECT b.branch_id, b.branch_name, COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions,
ROUND(SUM(t.is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions t
JOIN accounts a
ON t.account_id = a.account_id
JOIN customers c
ON c.customer_id = a.customer_id
JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id,b.branch_id, b.branch_name
ORDER BY fraud_rate DESC;

--What is the fraud rate for each transaction status (Success, Pending, and Failed)?--;

SELECT status,COUNT(*) AS total_transactions,
SUM(is_fraud = 1) AS fraud_transactions,
ROUND(SUM(is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions
GROUP BY status
ORDER BY fraud_rate DESC;


--Which transaction status and customer age group have the highest number of fraudulent transactions?--;

SELECT t.status,
CASE
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) < 18 THEN 'Under 18'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 18 AND 25 THEN '18-25'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 26 AND 35 THEN '26-35'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 36 AND 45 THEN '36-45'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 46 AND 60 THEN '46-60'
ELSE '60+'
END AS age_group,
COUNT(*) AS fraud_transactions FROM transactions t
JOIN accounts a
ON t.account_id = a.account_id
JOIN customers c
ON a.customer_id = c.customer_id
WHERE t.is_fraud = 1
GROUP BY t.status, age_group
ORDER BY t.status, fraud_transactions DESC;

--Which KYC status accounts for the most fraud transactions--;

SELECT 
CASE 
WHEN c.kyc_status IS NULL THEN 'Unknown'ELSE c.kyc_status
END AS kyc_status,
COUNT(*) AS total_fraud_transactions
FROM transactions t
JOIN accounts a
ON t.account_id = a.account_id
JOIN customers c
ON a.customer_id = c.customer_id
WHERE t.is_fraud = 1
GROUP BY 
CASE
WHEN c.kyc_status IS NULL THEN 'Unknown'ELSE c.kyc_status
END 
ORDER BY total_fraud_transactions DESC;

--Which account status has the highest fraud rate?--;

SELECT a.account_status,
COUNT(CASE WHEN t.is_fraud = 1 THEN 1 END) AS fraud_transactions,
COUNT(*) AS total_transactions,
ROUND(COUNT(CASE WHEN t.is_fraud = 1 THEN 1 END) * 100.0/ COUNT(*),2) AS fraud_rate
FROM accounts a
JOIN transactions t
ON a.account_id = t.account_id
GROUP BY a.account_status
ORDER BY fraud_rate DESC;


--What is the fraud rate by transaction type?--;

SELECT transaction_type,
COUNT(*) AS total_transactions,
SUM(is_fraud = 1) AS fraud_transactions,
ROUND(SUM(is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions
GROUP BY transaction_type
ORDER BY fraud_rate DESC;

--What is the fraud rate by transaction channel?--;

SELECT  channel,
COUNT(*) AS total_transactions,
SUM(is_fraud = 1) AS fraud_transactions,
ROUND(SUM(is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions
GROUP BY channel
ORDER BY fraud_rate DESC;

--What is the fraud rate by account_type?--;

SELECT 
CASE 
WHEN a.account_type IS NULL THEN 'Unknown'ELSE a.account_type
END AS account_type,t.status,
COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions,
ROUND(SUM(t.is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions t
JOIN accounts a
ON t.account_id = a.account_id
GROUP BY account_type,t.status
ORDER BY  account_type,fraud_rate desc ;


--Which device type has the highest fraud rate?--;

SELECT d.device_type,
CASE 
WHEN d.operating_system IS NULL THEN 'Unknown'ELSE d.operating_system
END AS operating_system,
COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions,
ROUND(SUM(t.is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions t
JOIN accounts a
ON t.account_id = a.account_id
JOIN customers c
ON a.customer_id=c.customer_id
JOIN devices d
ON c.customer_id=d.customer_id
GROUP BY d.device_type,operating_system
ORDER BY fraud_rate DESC;


--What is the monthly fraud rate trend?--;

SELECT DATE_FORMAT(t.transaction_date, '%Y-%m') AS month,t.status,
COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions,
ROUND(SUM(t.is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions t
GROUP BY month,t.status
ORDER BY month, fraud_rate DESC;

--What is the yearly fraud rate trend?--;

SELECT YEAR(transaction_date) AS year,status,
COUNT(*) AS total_transactions,
SUM(is_fraud=1) AS fraud_transactions,
ROUND(SUM(is_fraud) / COUNT(*) * 100, 2) AS fraud_rate
FROM transactions
GROUP BY YEAR(transaction_date),status
ORDER BY year,fraud_rate DESC;

--What is the fraud rate by status ?--;

SELECT status,COUNT(*) AS total_transactions,
SUM(is_fraud = 1) AS fraud_transactions,
ROUND(SUM(is_fraud = 1) * 100.0 / COUNT(*), 2) AS fraud_rate
FROM transactions
GROUP BY status
ORDER BY fraud_rate DESC;

--Which transaction amount range has the highest fraud rate?--;

SELECT  
CASE
WHEN amount <= 1000 THEN '0-1000'
WHEN amount <= 5000 THEN '1001-5000'
WHEN amount <= 10000 THEN '5001-10000'
ELSE '10001+'
END AS amount_range,status,
COUNT(*) AS total_transactions,
SUM(is_fraud = 1) AS fraud_transactions,
ROUND(SUM(is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions
GROUP BY amount_range,status
ORDER BY amount_range ,fraud_rate DESC ;

--Which customers have a fraud rate higher than the overall bank fraud rate?--;

SELECT c.customer_id,
COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions,
ROUND(SUM(t.is_fraud = 1) * 100.0 / COUNT(*),2) AS customer_fraud_rate
FROM transactions t
JOIN accounts a
ON t.account_id = a.account_id
JOIN customers c
ON a.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING SUM(t.is_fraud = 1) * 100.0 / COUNT(*) >(
                                           SELECT SUM(is_fraud = 1) * 100.0 / COUNT(*)FROM transactions)
ORDER BY customer_fraud_rate DESC;

--which beneficiaries have at least one fraudulent transaction and  the highest fraud rate?--;

SELECT b.beneficiary_id, b.beneficiary_name,
COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions,
ROUND(SUM(t.is_fraud = 1) * 100.0 / COUNT(*),2) AS fraud_rate
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
GROUP BY b.beneficiary_id,b.beneficiary_name
HAVING SUM(t.is_fraud = 1) > 0
ORDER BY fraud_rate DESC;

--What is the fraud rate by Beneficiary Bank and Transaction status?--;

SELECT
CASE
WHEN b.beneficiary_bank is Null THEN 'unknown' ELSE b.beneficiary_bank END AS beneficiary_bank,
t.status,
COUNT(*) AS total_transactions,
SUM(CASE WHEN t.is_fraud = 1 THEN 1 ELSE 0 END) AS fraud_transactions,
ROUND(SUM(CASE WHEN t.is_fraud = 1 THEN 1 ELSE 0 END) * 100.0/ COUNT(*),2) AS fraud_rate
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
GROUP BY beneficiary_bank,t.status
ORDER BY beneficiary_bank DESC,fraud_rate DESC;


