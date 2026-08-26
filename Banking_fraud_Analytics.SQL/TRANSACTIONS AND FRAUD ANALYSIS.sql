use fraud;

--What are the transaction type and the channel to transfer amount--;

SELECT DISTINCT transaction_type,channel
FROM transactions
ORDER BY transaction_type, channel;

--What is the total transaction amount?--;

SELECT SUM(amount) AS total_transaction_amount
FROM transactions;

--what is the highest amount of transaction--;

SELECT MAX(amount) AS highest_transaction_amount
FROM transactions;

--What is the total number of transactions?--;

SELECT COUNT(*) AS total_transactions
FROM transactions;

--Which Transaction type has the highest transaction volume.--;

SELECT transaction_type,COUNT(*) AS transaction_volume
FROM transactions
GROUP BY transaction_type
ORDER BY transaction_volume DESC
LIMIT 1;

--Which beneficiaries receive the highest total amount?--;

SELECT beneficiary_id,SUM(amount) AS total_amount_received
FROM transactions
GROUP BY beneficiary_id
ORDER BY total_amount_received DESC
LIMIT 1;

--Which banking channel is used most frequently?--;

SELECT channel,COUNT(*) AS transaction_count
FROM transactions
GROUP BY channel
ORDER BY transaction_count DESC;

---Which years customer have done more transaction.--;

SELECT YEAR(transaction_date) AS transaction_year,COUNT(*) AS total_transactions
FROM transactions
GROUP BY YEAR(transaction_date)
ORDER BY total_transactions DESC;

--What is the average transaction amount?--;

SELECT AVG(amount) AS average_transaction_amount
FROM transactions;

--What is the count of fraudulent transactions with failed status?--;

SELECT COUNT(*) AS total_fraud_failed
FROM transactions
WHERE is_fraud = 1 AND status = 'Failed';

--How many transactions were identified as non-fraudulent?--;

SELECT COUNT(*) AS total_non_fraud_transactions
FROM transactions
WHERE is_fraud = 0;

select sum(amount) from transactions
where is_fraud= 1;

--How many non-fraudulent transactions were successful and how many failed and Pending?--;

SELECT status,COUNT(*) AS total_transactions
FROM transactions
WHERE is_fraud = 0
GROUP BY status;

-How many fraudulent transactions were successful and how many failed and Pending?-
SELECT status,COUNT(*) AS total_transactions
FROM transactions
WHERE is_fraud = 1
GROUP BY status;

--What is the total number and total transaction amount of fraudulent transactions by status success,Failed and pending?--;

SELECT  status,count(*) AS total_transactions,
SUM(amount) AS total_fraud_success_amount
FROM transactions
WHERE is_fraud = 1 
group by status;

--What is the total number and total transaction amount of  non fraudulent transactions by status success, Failed and Pending?--;

SELECT  status,count(*) AS total__transactions,
SUM(amount) AS total_fraud_success_amount
FROM transactions
WHERE is_fraud = 0
group by status;

---Which transaction type and channel has more fraud happened?--;

SELECT transaction_type,channel,
COUNT(*) AS fraud_transaction_count
FROM transactions
WHERE is_fraud = 1
GROUP BY transaction_type, channel
ORDER BY fraud_transaction_count DESC;

--Which transaction type and channel have the highest number of fraudulent transactions by status (Success, Failed, and Pending)?--;

SELECT transaction_type,channel,status,
COUNT(*) AS fraud_transaction_count,
SUM(amount) AS total_fraud_amount
FROM transactions
WHERE is_fraud = 1
GROUP BY transaction_type, channel, status
ORDER BY fraud_transaction_count DESC;

--what is total fraud and non fraud amount--;

SELECT 
    CASE 
	WHEN is_fraud = 1 THEN 'Fraud'
	ELSE 'Non-Fraud'
    END AS fraud_status,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY is_fraud;

--Which beneficiary IDs are associated with fraudulent transactions?--;

SELECT beneficiary_id,COUNT(*) AS fraud_transaction_count
FROM transactions
WHERE is_fraud = 1
GROUP BY beneficiary_id
ORDER BY fraud_transaction_count DESC;

--Which type of description have frauds--;

SELECT description,COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY description
ORDER BY fraud_count DESC;

--Which beneficiary received the highest total transaction amount?--;

select b.beneficiary_name,SUM(t.amount) AS total_amount
FROM beneficiaries b
JOIN transactions t
ON b.beneficiary_id = t.beneficiary_id
GROUP BY b.beneficiary_id, b.beneficiary_name
ORDER BY total_amount DESC
LIMIT 1;

--What is the highest fraudulent transaction amount by transaction status?--;

SELECT status,MAX(amount) AS highest_fraud_amount
FROM transactions
WHERE is_fraud = 1
GROUP BY status
ORDER BY highest_fraud_amount DESC;

--Which banking channel has the highest number of transactions?--;

SELECT channel,COUNT(*) AS total_transactions
FROM transactions
GROUP BY channel
ORDER BY total_transactions DESC
limit 1;

---What are the fraud types--;

SELECT DISTINCT fraud_type from fraud_reports;

 --What is the total fraud amount recovered by transaction status?--;
 
SELECT t.status,COUNT(*) AS fraud_transaction_count,
SUM(t.amount) AS total_fraud_amount,
SUM(f.amount_recovered) AS total_recovered_amount
FROM transactions t
JOIN fraud_reports f
ON t.transaction_id = f.transaction_id
WHERE t.is_fraud = 1
GROUP BY t.status
ORDER BY total_recovered_amount DESC;

--What is the total fraud amount remaining after deducting the recovered amount for Success status?--;

select SUM(t.amount - f.amount_recovered) AS net_fraud_amount
FROM transactions t
JOIN fraud_reports f
ON t.transaction_id = f.transaction_id
WHERE t.is_fraud = 1 and t.status='Success';

--What is the total fraud amount remaining after deducting the recovered amount--;

select SUM(t.amount - f.amount_recovered) AS net_fraud_amount
FROM transactions t
JOIN fraud_reports f
ON t.transaction_id = f.transaction_id
WHERE t.is_fraud = 1;

--what is the total amount_recovered by is_fraud=1--;

SELECT SUM(F.amount_recovered) AS total_recovered_amount
FROM fraud_reports F
JOIN transactions t
ON F.transaction_id = t.transaction_id
WHERE is_fraud=1 ;

--what is the total amount_recovered--;

SELECT SUM(amount_recovered) AS total_recovered_amount
from  fraud_reports;

--Which fraud types have the highest number of fraudulent transactions by status?--;

SELECT  status,fr.fraud_type,COUNT(*) AS fraud_count
FROM transactions t
JOIN fraud_reports fr
ON t.transaction_id = fr.transaction_id
WHERE t.is_fraud = 1 
GROUP BY  status,fr.fraud_type
ORDER BY fr.fraud_type ;

--Dislay Total count by resolution_status--;

SELECT resolution_status ,COUNT(*) AS total_count
FROM fraud_reports
GROUP BY resolution_status
ORDER BY total_count DESC;

--Display Total count by investigation_notes--;

SELECT investigation_notes ,COUNT(*) AS total_count
FROM fraud_reports
GROUP BY investigation_notes
ORDER BY total_count DESC;

--Which fraud type has the highest number of fraudulent transactions?--;

SELECT fr.fraud_type,COUNT(*) AS fraud_count
FROM transactions t JOIN fraud_reports fr
ON t.transaction_id = fr.transaction_id
WHERE t.is_fraud = 1
GROUP BY fr.fraud_type
ORDER BY fraud_count DESC
LIMIT 1;

--Show beneficiaries have at least one fraudulent transaction.--;

SELECT b.beneficiary_name,b.beneficiary_id,
COUNT(*) AS total_transactions,
SUM(t.is_fraud = 1) AS fraud_transactions
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
GROUP BY b.beneficiary_id,b.beneficiary_name
HAVING SUM(t.is_fraud = 1) > 0
ORDER BY fraud_transactions DESC;

--Which beneficiary bank receives the highest number of transactions?--;

SELECT  b.beneficiary_bank,COUNT(*) AS total_transactions
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
GROUP BY b.beneficiary_bank
ORDER BY total_transactions DESC;

--Which beneficiary bank has the highest total transaction amount?--;

SELECT  b.beneficiary_bank,
SUM(t.amount) AS total_transaction_amount
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
GROUP BY b.beneficiary_bank
ORDER BY total_transaction_amount DESC
LIMIT 1;

--What is the transaction volume by beneficiary bank?--;

SELECT b.beneficiary_bank,
COUNT(*) AS transaction_volume
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
GROUP BY b.beneficiary_bank
ORDER BY transaction_volume DESC;

--Which beneficiary banks are most commonly used by customers?--;

SELECT b.beneficiary_bank,
COUNT(DISTINCT c.customer_id) AS customers_count
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
JOIN accounts a
ON b.account_id=a.account_id
JOIN customers c
ON a.customer_id = c.customer_id
GROUP BY b.beneficiary_bank
ORDER BY customers_count DESC;

--Which beneficiary bank has the highest number of fraudulent transactions?--;

SELECT b.beneficiary_bank,
COUNT(*) AS fraud_transactions
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
WHERE t.is_fraud = 1
GROUP BY b.beneficiary_bank
ORDER BY fraud_transactions DESC
LIMIT 1;

--Which beneficiary bank has the highest total fraudulent transaction amount?--;

SELECT  b.beneficiary_bank,
SUM(t.amount) AS total_fraud_amount
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
WHERE t.is_fraud = 1
GROUP BY b.beneficiary_bank
ORDER BY total_fraud_amount DESC
LIMIT 1;

--What is the total fraudulent transaction amount by beneficiary bank and Transaction status?--;

SELECT b.beneficiary_bank,t.status,
sum(t.amount) AS total_fraud_amount
FROM transactions t
JOIN beneficiaries b
ON t.beneficiary_id = b.beneficiary_id
WHERE t.is_fraud = 1
GROUP BY b.beneficiary_bank,t.status
ORDER BY b.beneficiary_bank,total_fraud_amount DESC;

-- which time Fraudulent transaction happened--;

SELECT HOUR(transaction_time) AS fraud_hour,
COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY  HOUR(transaction_time)
ORDER BY fraud_count DESC;

--which time  more Fraudulent transaction happened by status--;

SELECT status,HOUR(transaction_time) AS fraud_hour,
COUNT(*) AS fraud_count
FROM transactions
WHERE is_fraud = 1
GROUP BY status, HOUR(transaction_time)
ORDER BY status,fraud_count DESC;

-- which year has the highest number of fraud--;

SELECT YEAR(transaction_date) AS Fraud_Year,
COUNT(*) AS Total_Fraud_Transactions
FROM Transactions
WHERE is_fraud = 1
GROUP BY YEAR(transaction_date)
ORDER BY Fraud_Year;

--which year has the highest fraud amount--;

SELECT YEAR(transaction_date) AS Fraud_Year,
SUM(amount) AS Total_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1
GROUP BY YEAR(transaction_date)
ORDER BY Fraud_Year;

--which year has the highest fraud amount by status--;

SELECT YEAR(transaction_date) AS Fraud_Year,status,
SUM(amount) AS Total_Fraud_Amount
FROM Transactions
WHERE is_fraud = 1 
GROUP BY status, YEAR(transaction_date)
ORDER BY status,Total_Fraud_Amount desc;


