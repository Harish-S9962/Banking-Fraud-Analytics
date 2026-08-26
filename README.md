# Banking Fraud Analytics

**Created by: Harish S.**

## 📌 Project Overview

This project analyzes banking customer, account, transaction, fraud, device, and login data to identify suspicious patterns, understand fraud risk, and provide actionable business insights.

The project uses **SQL (MySQL)** for data cleaning and analysis and **Power BI** for interactive dashboard development.

## 🎯 Business Objective

The main objective of this project is to analyze banking data and identify:

- Customer and branch-level patterns
- Account distribution and activity
- Transaction and fraud trends
- Fraud-prone channels and transaction types
- Device and login-related security risks
- Areas where banking security and monitoring can be improved

## 🛠️ Tools & Technologies

- **MySQL** – Data cleaning and SQL analysis
- **Power BI** – Data visualization and dashboard development
- **DAX** – Measures and time-intelligence calculations
- **Excel / CSV** – Source data preparation
- **GitHub** – Project documentation and version control

## 📊 Dataset Overview

The project analyzes banking data related to customers, branches, accounts, transactions, fraud, devices, and login activity.

### Dataset Size

- **Customers:** 5,000
- **Accounts:** 7,000
- **Branches:** 50
- **Transactions:** 50,000
- **Devices:** 6,000

### Main Tables

1. Branches
2. Customers
3. Accounts
4. Devices
5. Beneficiaries
6. Login Activity
7. Transactions
8. Fraud Reports

## 🧹 Data Cleaning

Data cleaning and validation were performed using **MySQL**.

Key activities included:

- Identifying duplicate records
- Handling NULL and blank values
- Checking data types and inconsistent values
- Validating primary and foreign key relationships
- Checking invalid transaction and account values
- Standardizing text and date-related fields
- Preparing clean data for Power BI analysis

## 🗄️ SQL Analysis

SQL analysis was performed using **MySQL** to clean the data and answer key banking and fraud-related business questions.

### SQL Analysis Areas

- Customer and demographic analysis
- Branch performance analysis
- Account type and account status analysis
- Transaction analysis
- Fraud transaction analysis
- Fraud type analysis
- Device and login activity analysis
- Business problem analysis

### Key SQL Techniques Used

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `JOIN`
- `LEFT JOIN`
- `CASE`
- Aggregate functions such as `COUNT()`, `SUM()`, and `AVG()`
- `ROW_NUMBER()`
- Common Table Expressions (CTEs)
- Date and time functions
- Window functions
- Data cleaning and validation queries

### SQL Scripts

The SQL scripts used for the project are available in the **SQL** folder.

They include:

- Data cleaning
- Customer analysis
- Account analysis
- Transaction and fraud analysis
- Device and login analysis
- Business problem queries
  
## 📈 Power BI Dashboard

An interactive Power BI dashboard was developed to analyze banking operations, customer behavior, accounts, fraud, devices, and login activity.

### Dashboard Pages

#### 1. Banking Overview

Provides an overall view of banking transactions and fraud performance, including key KPIs and transaction trends.

#### 2. Branches & Customer Analysis

Analyzes:

- Customer distribution by branch
- Customer demographics
- Age groups
- Gender distribution
- KYC status
- Branch-level fraud rate

#### 3. Account Analysis

Analyzes:

- Account types
- Account status
- Account balances
- Fraud rate by account type
- Fraud rate by account status

#### 4. Fraud Analysis

Analyzes:

- Total fraud transactions
- Fraud amount
- Fraud rate
- Fraud types
- Fraud trend
- Fraud patterns across transaction categories

#### 5. Device & Login Analysis

Analyzes:

- Total devices
- Trusted vs untrusted devices
- Device types
- Successful vs failed logins
- Login activity
- Location-based login patterns

### Power BI Features Used

- KPI Cards
- Bar Charts
- Column Charts
- Line Charts
- Donut Charts
- Slicers
- Tables
- DAX Measures
- Time Intelligence
- Interactive filtering
