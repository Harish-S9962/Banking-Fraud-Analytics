use fraud;

--Which customers have more than one bank account?--;

SELECT customer_id, COUNT(account_id) AS total_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1
ORDER BY total_accounts DESC;

---Which customers age group has the highest number of accounts--;

SELECT
CASE
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 18 AND 25 THEN '18-25'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 26 AND 35 THEN '26-35'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 36 AND 45 THEN '36-45'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 46 AND 55 THEN '46-55'
ELSE '56+'
END AS age_group,
COUNT(a.account_id) AS total_accounts
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY
CASE
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 18 AND 25 THEN '18-25'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 26 AND 35 THEN '26-35'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 36 AND 45 THEN '36-45'
WHEN TIMESTAMPDIFF(YEAR, c.dob, CURDATE()) BETWEEN 46 AND 55 THEN '46-55'
ELSE '56+'
END
ORDER BY total_accounts DESC
LIMIT 1;


---Which account type has the highest total balance?--;

select account_type,sum(balance) as highest_balance
from accounts
group by account_type
order by highest_balance desc
limit 1;

---Which account type of customer have highest balance?--;

SELECT customer_id, account_type,
MAX(balance) AS highest_balance
FROM accounts
GROUP BY customer_id,account_type
ORDER BY highest_balance DESC
LIMIT 1;


---Which branch have highest balance accounts?--;

SELECT b.branch_id,b.branch_name,
SUM(a.balance) AS total_balance
FROM accounts a
JOIN customers c
ON c.customer_id =a.customer_id
join branches b 
on c.branch_id=b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_balance DESC
LIMIT 1;

--Top 10 branches with the highest number of active accounts--;

SELECT b.branch_id,b.branch_name,
COUNT(a.account_id) AS active_accounts
FROM accounts a JOIN customers c
ON c.customer_id = a.customer_id
JOIN branches b
ON c.branch_id = b.branch_id
WHERE a.account_status = 'Active'
GROUP BY b.branch_id, b.branch_name
ORDER BY active_accounts DESC
LIMIT 10;

--Total number of  active accounts--;

SELECT COUNT(account_id) AS total_active_accounts
FROM accounts
where  account_status = 'Active';

-- Total number of inactive and closed accounts--;

SELECT  account_status,COUNT(account_id) AS total_accounts
FROM accounts
where  account_status in ('Inactive', 'closed')
group by account_status;

---Show account status distribution by each branch.--;

SELECT b.branch_id,b.branch_name,
count(case when account_status='Active' then 1 end) as Active,
count(case when account_status='Inactive' then 1 end) as Inactive,
count(case when account_status='Closed' then 1 end) as Closed,
COUNT(a.account_id) AS total_accounts
FROM accounts a JOIN customers c
ON a.customer_id = c.customer_id
JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY b.branch_id;

--Which type of account have more customers?--;

SELECT account_type,COUNT(DISTINCT customer_id) AS total_customers
FROM accounts
GROUP BY account_type
ORDER BY total_customers DESC;

--Show account_type distribution by each branch--;

SELECT b.branch_id,b.branch_name,
count(case when account_type='Savings' then 1 end) as saving_account,
count(case when account_type='Current' then 1 end) as current_account,
count(case when account_type='Salary' then 1 end) as salary_account,
count(case when account_type is null then 1 end) as null_account,
COUNT(a.account_id) AS total_accounts
FROM accounts a JOIN customers c
ON a.customer_id = c.customer_id
JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY b.branch_id;

---Which year had the highest number of newly accounts opened--;

SELECT YEAR(opening_date) AS opened_year,
COUNT(account_id) AS total_accounts
FROM accounts
GROUP BY YEAR(opening_date)
ORDER BY total_accounts DESC
limit 1;

--Which type of account have negative balance?--;

SELECT account_type,COUNT(account_id) AS negative_balance_accounts
FROM accounts
WHERE balance < 0
GROUP BY account_type
ORDER BY negative_balance_accounts DESC;

--Which branch has the highest number of accounts?--;

SELECT b.branch_id,b.branch_name,COUNT(a.account_id) AS total_accounts
FROM accounts a
JOIN customers c
ON a.customer_id = c.customer_id
JOIN branches b
ON c.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name
ORDER BY total_accounts DESC
LIMIT 1;

---What is the total bank balance across all accounts?--;

SELECT SUM(balance) AS total_bank_balance
FROM accounts;

--Which account status has the highest number of fraudulent transactions?--;

SELECT a.account_status,t.status,
COUNT(*) AS fraud_transaction_count
FROM accounts a
JOIN transactions t
ON a.account_id = t.account_id
WHERE t.is_fraud = 1
GROUP BY t.status ,a.account_status
ORDER BY a.account_status,t.status,fraud_transaction_count DESC;

