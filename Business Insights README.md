# Business Insights

## 1. Banking Overview

### Key Findings
- Total Branches = 50
- Total Customers = 5,000
- Total Accounts = 7,000
- Total Transactions = 50K
- Total Transaction Amount = 437.66M
- Total Fraud Transactions = 1,026
- Total Fraud Amount = 41.47M
- Fraud Rate = 2.05%

### Business Insights
- The bank serves **5,000 customers** across **50 branches**, with **7,000 accounts**.
- A total transaction value of **437.66M** indicates significant banking activity.
- **1,026** fraud transactions were identified, resulting in an overall fraud rate of **2.05%**.
- The transaction data shows a need for continued fraud monitoring and security controls.

### Recommendations
- **Strengthen Fraud Monitoring**: Closely monitor suspicious and high-value transactions.
- **Improve Customer Security**: Promote secure banking practices and fraud awareness.
- **Monitor Branch Performance**: Compare branch-level transaction and fraud rates to identify high-risk branches.
- **Improve Data Quality**: Regularly validate customer, account, and transaction data for accurate reporting.

## 2. Branches & Customers Analysis

### Key Findings
- Total Branches = 50
- Total Customers = 5,000
- Branch Fraud Rate = 2.05%

### Business Insights
- "The bank has 5,000 customers.": Female 1,886, Male 1,887, Others 587.
- Gender data quality: 640 records (Fraud Rate 1.81%) have missing gender information, which may affect gender-based customer segmentation.
- Female fraud rate (2.16%) is greater than Male fraud rate (2.11%) and Others (1.80%).
- Overall fraud rate is 2.05%.
- Age group wise (Female): 26-35 has the highest fraud rate at 2.45%, followed by 66+ at 2.29% and 46-55 at 2.265%.
- Age group wise (Male): 56-65 has the highest fraud rate at 2.56%, followed by 66+ at 2.18% and 46-55 at 2.13%.
- By KYC status: Female customers have the highest fraud rate in "Pending" status (2.32%); Male customers have the highest fraud rate in "Missing" status (2.36%).
- Overall breakdown: Male customers are 37.74% (fraud rate 2.11%), Female customers are 37.72% (fraud rate 2.16%), Missing value customers are 12.8% (fraud rate 1.85%), Others are 11.74% (fraud rate 1.80%).
- By age group: 56-65 has 808 customers (fraud rate 2.28%), 46-55 has 871 customers (fraud rate 2.28%), 26-35 has 807 customers (fraud rate 2.085%), 66+ has the highest customer count at 935 (fraud rate 2.07%), 36-45 has 883 customers (fraud rate 1.77%), and 18-25 has 696 customers (fraud rate 1.95%).
- By KYC status: Missing value (data quality issue) has 809 customers with a high fraud rate of 2.17%, Rejected has 835 customers (fraud rate 2.14%), Pending has 1,677 customers (fraud rate 2.06%), and Verified has 1,679 customers (fraud rate 1.97%).

### Recommendations
- Improve KYC verification for missing, pending, and rejected records.
- Monitor the **56-65** and **46-55** age groups more closely due to higher fraud rates.
- Improve missing gender and KYC data quality.
- Use **risk-based monitoring** for customers and transactions with higher fraud rates.
- Regularly review fraud patterns to identify unusual customer behaviour.
- Raise customer awareness based on these findings.

## 3. Account Analysis

### Key Findings
- Total Accounts = 7,000
- Total Balance = 172.08M
- Total Customers = 5,000
- Current Account = 56.05M
- Salary Account = 30.58M
- Savings Account = 58.38M

### Business Insights
- Savings accounts have the highest balance amount.
- Account status: Inactive accounts (2,792) have the highest fraud rate at 2.18%; Active accounts have the highest count at 2,846 with a fraud rate of 2.03%; Closed accounts (1,362) have a fraud rate of 1.84%.
- Account type: 1,135 accounts have an unknown account type with the highest fraud rate of 2.27%, indicating a data quality issue. Salary accounts (1,216) have a fraud rate of 2.20%, current accounts (2,313) have a fraud rate of 2.00%, and savings accounts (2,336) have a fraud rate of 1.93%.

### Recommendations
- **Fix Unknown Account Types**: Validate and update the **1,135 unknown accounts** to improve data quality.
- **Monitor Inactive Accounts**: Closely monitor inactive accounts due to their **highest fraud rate of 2.18%**.
- **Review Salary Accounts**: Strengthen monitoring of salary accounts due to their **2.20% fraud rate**.
- **Protect High-Balance Accounts**: Maintain strong controls for savings accounts, which have the **highest balance of 58.38M**.

## 4. Fraud Analysis

### Key Findings
- Total Fraud Transactions = 1,026
- Total Transactions = 50K
- Total Transaction Amount = 437.66M
- Total Fraud Amount = 41.47M
- Successful Fraud Transactions = 16.74M
- Average Fraud Amount = 40.42K
- Non-Fraud Amount = 396.19M
- Failed Fraud Transactions = 16.38M
- Fraud Rate = 2.05%
- Fraud Type Rate = 1.00%

### Business Insights
- Fraud type breakdown: Phishing (303 cases, 30%), Account Takeover (161, 16%), SIM Swap (157, 15%), Card Skimming (142, 14%), Identity Theft (139, 14%), and Unknown (124, 12%). Phishing and Account Takeover together account for 45% of fraud cases.
- Transaction type: IMPS has 8,406 transactions with 182 fraudulent (2.17%), NEFT has 16,772 transactions with 347 fraudulent (2.07%), UPI has 16,435 transactions with 332 fraudulent (2.02%), and RTGS has 8,387 transactions with 165 fraudulent (1.97%). IMPS and NEFT show the highest fraud rates.
- Banking channel: Mobile App has 20,108 transactions with 431 fraudulent (2.14%), Net Banking has 10,003 transactions with 201 fraudulent (2.01%), ATM has 9,916 transactions with 199 fraudulent (2.01%), and Branch has 9,973 transactions with 195 fraudulent (1.96%). Here Mobile App and Net Banking have high fraud rate.
- Transaction status: Pending has 9,991 transactions with 219 fraudulent (2.19%), Failed has 19,928 transactions with 418 fraudulent (2.10%), and Success has 20,081 transactions with 389 fraudulent (1.94%). Pending and Failed statuses need closer monitoring.
- Transaction description: Fund Transfer (345 fraud cases), Missing value/data quality issue (190), Merchant Payment (172), Bill Payment (165), ATM Withdrawal (154). Fund Transfer and missing-value entries show the highest fraud counts.
- Fraud timing: Highest fraud counts occur at 18:00 (56), 13:00 (52), 20:00 (51), 15:00 (51), 12:00 (49), 23:00 (46), 03:00 (45), 16:00 (44), 17:00 (44), 09:00 (44), and other hours with decreasing counts. 18:00 and 13:00 show the highest fraud transaction counts.
- Amount range: Transactions above 10,001 have 14,801 total with 786 fraudulent (5.31%); 5,001-10,000 have 12,381 total with 100 fraudulent (0.81%); 1,001-5,000 have 17,160 total with 110 fraudulent (0.64%); 0-1,000 have 5,658 total with 30 fraudulent (0.53%). Higher-value transactions show significantly higher fraud rates.
- Year-wise fraud rate: 2022-23 (2.06%), 2023-24 (2.10%), 2024-25 (1.93%). 2023-24 had the highest fraud rate, which decreased in 2024-25, though continued monitoring is recommended.

### Recommendations
- **Prevent Phishing and Account Takeover**: Strengthen authentication and customer awareness.
- **Monitor High-Value Transactions**: Closely monitor transactions above **10,001** due to the **5.31% fraud rate**.
- **Secure Mobile App and Other Channels**: Strengthen security for mobile app transactions and other channels.
- **Monitor IMPS**: Increase monitoring due to its **2.17% fraud rate**.
- **Fix Data Quality**: Correct the **190 missing fraud descriptions**.
- **Monitor Pending/Failed Transactions**: Apply additional verification to suspicious transactions.

## 5. Device & Login Analysis

### Key Findings
- Total Devices = 6,000
- Total Trusted Devices = 2,327
- Total Untrusted Devices = 2,475
- Success Login = 15,145
- Failed Login = 14,855

### Business Insights
- Device type: Desktop has 939 trusted and 991 untrusted devices; Mobile has 920 trusted and 1,010 untrusted devices; Tablet has 468 trusted and 474 untrusted devices.
- Of 6,000 registered devices, 2,475 (41%) are untrusted. Login activity is nearly evenly split — 15,145 successful vs. 14,855 failed attempts (49.5%).
- Ghaziabad recorded the highest number of failed login attempts (98), followed by Aurangabad (95), indicating locations that may require closer monitoring for unusual login activity.

### Recommendations
- **Secure Untrusted Devices**: Strengthen verification for the 2,475 untrusted devices.
- **Reduce Failed Logins**: Investigate repeated failed login attempts and improve authentication.
- **Monitor High-Risk Locations**: Closely monitor Ghaziabad and Aurangabad for unusual login activity.
- **Enable MFA**: Use multi-factor authentication (MFA) to improve login and transaction security.
