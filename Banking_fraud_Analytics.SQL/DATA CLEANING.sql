create database Fraud;

use Fraud;

create table Branches(
branch_id INT,
branch_name varchar(50),
city varchar(50),
state varchar(50),
ifsc_code varchar(50),
contact_number varchar(50));

select * from branches;

Create table Customers(
customer_id  INT ,
branch_id INT,
first_name varchar(20),
last_name varchar(20),
dob date,
gender varchar(10),
email varchar(50),
phone_number varchar(11),
address varchar(50),
city varchar(40),
state varchar(20),
pincode varchar(15),
registration_date date,
kyc_status varchar(15)
 );
 
 select *from Customers;

Create table Accounts(
account_id INT,
customer_id INT,
account_type varchar(20),
account_number varchar(30),
balance varchar(20),
currency varchar(15),
account_status varchar(20),
opening_date date
 );
 
 select * from accounts;

Create table Devices(
device_id INT ,
customer_id INT,
device_type varchar(30),
operating_system varchar(15),
device_hash varchar(30),
ip_address varchar(40),
first_used_date date,
is_trusted varchar(10) );

select * from devices;

Create table Beneficiaries(
beneficiary_id INT ,
account_id INT,
beneficiary_name varchar(30),
beneficiary_account_number varchar(40),
beneficiary_bank varchar(15),
ifsc_code varchar(30),
added_date date,
relationship varchar(20));

select * from Beneficiaries;

Create table Login_Activity(
login_id INT,
customer_id INT,
device_id INT,
login_timestamp timestamp,
login_status varchar(20),
ip_address varchar(45),
location varchar(40),
session_duration_sec INT);

select * from Login_Activity;

Create table Transactions(
transaction_id INT ,
account_id INT,
beneficiary_id varchar(20),
transaction_type varchar(20),
amount varchar(20),
transaction_date date,
transaction_time time,
channel varchar(30),
status varchar(30),
is_fraud boolean,
description varchar(60));

select * from transactions;

select count(*) from transactions;

Create table Fraud_Reports(
report_id INT ,
transaction_id INT,
reported_date date,
fraud_type varchar(30),
reported_by varchar(30),
resolution_status varchar(30),
amount_recovered decimal(20,4),
investigation_notes varchar(60));

select * from Fraud_Reports;

select *from Customers;

ALTER TABLE branches
ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

select branch_id, count(*) from Branches
group by branch_id
having count(*)>1
order by branch_id;

SELECT id,branch_id,
ROW_NUMBER() OVER (PARTITION BY branch_id ORDER BY id) AS rn
FROM branches;

with duplicate_row as(
select id,
row_number() over(partition by branch_id order by id) as Rn from branches)
DELETE FROM branches
WHERE id IN (SELECT id
    FROM duplicate_row
    WHERE rn > 1);
    
ALTER TABLE branches
DROP COLUMN id;
    
Alter table branches
add primary key(branch_id);

select * from branches;

set SQL_safe_updates=0;

update branches
set branch_name=ltrim(replace(branch_name,city," "));

select * from branches;

UPDATE branches
SET branch_name = CONCAT(city, ' ', branch_name);

update branches
set branch_name= "Mumbai Central Branch"
where branch_id=2;

update branches
set branch_name= " Ludhiana South Branch"
where branch_id=34;

update branches
set branch_name= " Ahmedabad Main Branch "
where branch_id=44;

update branches
set branch_name= " Kochi South Branch "
where branch_id=50;

UPDATE branches
SET branch_name = trim(branch_name);

select * from branches;

update branches
set city=concat(upper(left(city,1)),lower(substring(city,2)));

UPDATE branches
SET city = trim(city);

select contact_number from branches
where length(contact_number)=10;

select contact_number from branches
where length(contact_number)=9;

select contact_number,
case 
when length(contact_number)=10 then "Valid Number"
else "Truncated"
end as Phone_Status from branches;

ALTER TABLE branches
ADD COLUMN phone_status VARCHAR(20);

UPDATE branches
SET phone_status =
CASE
when length(contact_number)=10 then "Valid Number"
else "Truncated"
end;

select * from branches;

select customer_id,email, count(*)
from customers
group by customer_id,email
having count(*)>1;

select customer_id,email,
row_number() over(partition by customer_id order by customer_id)as rn
from customers;

alter table customers
add column id int auto_increment primary key;

with duplicate_rows as(
select id,customer_id,email,
row_number() over(partition by customer_id order by id) as rn from customers)
delete from customers 
where id in( SELECT id
FROM duplicate_rows
WHERE rn > 1);
    
select id,customer_id,email, count(*)
from customers
group by id,customer_id,email
having count(*)>1; 

select * from customers;

alter table customers 
drop column id;

alter table customers
add primary key(customer_id);

select count(*) from customers;

select account_id, count(*)
from accounts
group by account_id
having count(*)>1; 

update customers
set pincode=null
where pincode= '';

select * from accounts;

alter table accounts
add column id int auto_increment primary key;

with duplicate_rows as(
select id,account_id,
row_number() over(partition by account_id order by id) as rn from accounts)
delete from accounts
where id in(SELECT id
FROM duplicate_rows
WHERE rn > 1);

select id,account_id, count(*)
from accounts
group by id,account_id
having count(*)>1; 

alter table accounts
drop column id;

alter table accounts
add primary key(account_id);

describe accounts;

select * from accounts;

select * from devices;

select device_id, count(*)
from devices
group by device_id
having count(*)>1; 

alter table devices
add column id int auto_increment primary key;

with duplicate_rows as(
select id, device_id,
row_number() over(partition by device_id  order by id) as rn from devices)
delete from devices
where id in(SELECT id
FROM duplicate_rows
WHERE rn > 1);
    
select device_id, count(*)
from devices
group by device_id
having count(*)>1; 

alter table devices
drop column id;

alter table devices
add primary key(device_id);

describe devices;

select * from devices;

select * from beneficiaries;

select count(*) from beneficiaries;

select beneficiary_id, count(*)
from beneficiaries
group by beneficiary_id
having count(*)>1; 

alter table beneficiaries
add primary key(beneficiary_id);

select * from login_activity;

select count(*) from login_activity;

select login_id, count(*)
from login_activity
group by login_id
having count(*)>1; 

alter table login_activity
add primary key(login_id);

describe login_activity;

select * from transactions;

select transaction_id, count(*)
from transactions
group by transaction_id
having count(*)>1; 

select count(*) from transactions;

alter table transactions
add column id int auto_increment primary key;

select * from transactions;

with duplicate_rows as(
select id ,transaction_id,
row_number() over(partition by transaction_id  order by id) as rn from transactions)
delete from transactions
where id in(SELECT id
FROM duplicate_rows
WHERE rn > 1);
    
 select id,transaction_id, count(*)
from transactions
group by id,transaction_id
having count(*)>1;    

alter table transactions
drop column id;

alter table transactions
add primary key(transaction_id);

describe transactions;

select * from fraud_reports;

select count(*) from fraud_reports;

select report_id, count(*)
from fraud_reports
group by report_id
having count(*)>1;    

alter table fraud_reports
add column id int auto_increment primary key;

with duplicate_rows as(
select id ,report_id,
row_number() over(partition by report_id order by id) as rn from fraud_reports )
delete from fraud_reports
where id in(SELECT id
FROM duplicate_rows
WHERE rn > 1);
    
alter table fraud_reports
drop column id;

alter table fraud_reports
add primary key (report_id);

alter table branches
modify column contact_number varchar(10);

describe transactions;

alter table transactions
modify column is_fraud boolean;

alter table customers
add Foreign key (branch_id) references Branches (branch_id );

SELECT branch_id from customers
where branch_id>50;

update customers
set branch_id=null
where branch_id=9999;

SELECT COUNT(*)
FROM customers
WHERE branch_id = 9999;

select branch_id from customers;

select * from customers
where branch_id is null;

alter table customers
add Foreign key (branch_id) references Branches (branch_id );

alter table accounts
add Foreign key (customer_id) References Customers (customer_id) ;

SELECT a.customer_id
FROM accounts a
LEFT JOIN customers c
    ON a.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

update accounts
set customer_id=null
where customer_id=999999;

alter table accounts
add Foreign key (customer_id) References Customers (customer_id) ;

alter table devices
add Foreign Key (customer_id ) references Customers (customer_id) ;


alter table beneficiaries
add Foreign Key (account_id) references Accounts(account_id);


alter table Login_Activity
add foreign key(customer_id) references Customers(customer_id),
add Foreign Key( device_id ) references Devices(device_id);

alter table transactions
add foreign key(account_id) references Accounts(account_id),
add foreign key(beneficiary_id ) references Beneficiaries(beneficiary_id);

select t.account_id from transactions t left join accounts a
on t.account_id=a.account_id
where a.account_id is null;

update transactions
set account_id=null
where account_id=888888;

select t.beneficiary_id from transactions t left join beneficiaries b
on t.beneficiary_id=b.beneficiary_id
where b.beneficiary_id is null;

update transactions
set beneficiary_id=null
where beneficiary_id=' ';

select beneficiary_id from transactions;

alter table transactions
add foreign key(account_id) references Accounts(account_id),
add foreign key(beneficiary_id ) references Beneficiaries(beneficiary_id);

select t.beneficiary_id from transactions t left join beneficiaries b
on t.beneficiary_id=b.beneficiary_id
where b.beneficiary_id is null;

alter table transactions
modify column beneficiary_id int;

UPDATE transactions
SET beneficiary_id = NULL
WHERE beneficiary_id = '';

SELECT COUNT(*)
FROM transactions
WHERE beneficiary_id = '';

alter table Fraud_Reports
add foreign key(transaction_id) references Transactions(transaction_id );
 
select * from branches;
 
select * from customers;
 
update customers
set first_name=trim(first_name);
 
 update customers
 set gender=
 case
  when gender= 'M' then 'Male'
  when gender= 'F' then 'Female'
  when gender= 'male' then 'Male'
  when gender= 'MALE' then 'Male'
  when gender= 'FEMALE' then 'Female'
  when gender='female' then 'Female'
  when gender ='Other' then 'Other'
  end;
  
  
select * from customers;
   
select gender from customers
where gender is Null;
   
select * from customers 
where email not like '%@%.%';

SELECT DISTINCT
UPPER(SUBSTRING_INDEX(email, '@',-1)) AS email_domain
FROM customers
WHERE email  LIKE '%@%';

SELECT DISTINCT
lower(SUBSTRING_INDEX(email, '@', -1)) AS email_domain
FROM customers
WHERE email LIKE '%@%';


UPDATE customers
SET email = REPLACE(REPLACE(REPLACE(LOWER(email),
'gmail.com', '@gmail.com'),
'yahoo.com', '@yahoo.com'),
'outlook.com', '@outlook.com')
WHERE email NOT LIKE '%@%';


UPDATE customers
SET email = REPLACE(REPLACE(REPLACE(upper(email),
'GMAIL.COM', '@gmail.com'),
'YAHOO.COM', '@yahoo.com'),
'OUTLOOK.COM', '@outlook.com')
WHERE email NOT LIKE '%@%';

select count( phone_number) from customers
where length(phone_number)<>10;

ALTER TABLE customers
ADD COLUMN phone_status VARCHAR(20);

update customers
set phone_status=
case
when length(phone_number)=10 then 'Valid Number'
when length(phone_number)<>10 then 'Truncated'
end;

select * from customers;

alter table customers
modify column phone_status varchar(20) after phone_number;

select * from customers
where address is null;

select * from customers
where city and state = '';

select * from customers 
where pincode = '';

update customers
set pincode= null
where pincode= '';

select * from customers
where pincode is null;

select * from customers
where kyc_status = '';

update customers
set kyc_status=
case
when kyc_status='PENDING' then 'Pending'
when kyc_status='REJECTED' then 'Rejected'
when kyc_status='VERIFIED' then 'Verified'
when kyc_status= '' then null
end;

select * from customers;

select * from customers
where gender is null;

update customers
set gender=null
where gender = 'null';

select * from customers 
where kyc_status is null;

select * from accounts;

SELECT balance as negative_Balance
FROM accounts
WHERE balance < 0 ;

update accounts
set balance= Null
where balance= '';

update accounts
set account_type=
case
when account_type='CURRENT' then 'Current'
when account_type='SAVINGS' then 'Savings'
when account_type='SALARY' then 'Salary'
when account_type= '' then null
end;

ALTER TABLE accounts
MODIFY balance DECIMAL(15,2);

SELECT COUNT(*) AS negative_balances
FROM accounts
WHERE balance < 0;

SELECT account_number,balance,
CASE
when balance < 0 THEN 'Negative Balance'
else 'Valid'
END AS balance_status
FROM accounts;

SELECT balance as negative_Balance
FROM accounts
WHERE balance < 0 ;

update accounts
set currency=
case
when currency='inr' then 'INR'
when currency= '' then null
end;

alter table accounts
add column  balance_status varchar(20);

alter table accounts
modify column balance_status varchar(20) after balance;

update accounts
set balance_status=
CASE
when balance < 0 THEN 'Negative Balance'
else 'Valid'
end;

select * from accounts;

select account_status from accounts
where account_status is null;

update accounts
set account_status=
case
when account_status='INACTIVE' then 'Inactive'
when account_status='active' then 'Active'
when account_status='CLOSED' then 'Closed'
when account_status='ACTIVE' then 'Active'
end;

select * from devices;

select * from devices
where device_type is null;

select * from devices
where device_type is null;

select * from devices;

update devices
set device_type='Desktop'
where device_type='DESKTOP';

update devices
set device_type='Mobile'
where device_type='MOBILE';

update devices
set device_type='Tablet'
where device_type='TABLET';

update devices
set device_type='Mobile'
where device_type='mobile';

update devices
set device_type='Tablet'
where device_type='tablet';

update devices
set operating_system='ios'
where operating_system='IOS';

update devices
set operating_system='Android'
where operating_system='android';

update devices
set operating_system='Android'
where operating_system='ANDROID';

update devices
set operating_system='Windows'
where operating_system='WINDOWS';

update devices
set operating_system='Macos'
where operating_system='macos';

update devices
set operating_system= null
where operating_system='';

set sql_safe_updates=0;

update devices
set is_trusted=
case 
when is_trusted='yes' then 'Yes'
when is_trusted='no' then  'No'
when is_trusted='YES' then 'Yes'
when is_trusted='NO' then 'No'
when is_trusted= '' then null
end;

select * from devices;

select * from beneficiaries;

select * from beneficiaries
where beneficiary_bank is null;

select * from beneficiaries
where beneficiary_bank is null;

SELECT COUNT(*) - COUNT(beneficiary_bank) AS null_count
FROM beneficiaries;

select beneficiary_id,beneficiary_bank from beneficiaries;

update beneficiaries
set beneficiary_bank='HDFC Bank'
where beneficiary_bank='Hdfc';

update beneficiaries
set beneficiary_bank='HDFC Bank'
where beneficiary_bank='HDFC';

update beneficiaries
set beneficiary_bank='PNB Bank'
where beneficiary_bank='Pnb';

update beneficiaries
set beneficiary_bank='SBI Bank'
where beneficiary_bank='Sbi';

update beneficiaries
set beneficiary_bank='SBI Bank'
where beneficiary_bank='SBI';

update beneficiaries
set beneficiary_bank='Axis Bank'
where beneficiary_bank='axis';

update beneficiaries
set beneficiary_bank='ICICI Bank'
where beneficiary_bank='ICICI';

update beneficiaries
set beneficiary_bank= null
where beneficiary_bank='';

select * from beneficiaries;

update beneficiaries
set relationship= null
where relationship= '';

update beneficiaries
set relationship='Business'
where relationship='business';

update beneficiaries
set relationship='Family'
where relationship='family';

update beneficiaries
set relationship='Self'
where relationship='self';

update beneficiaries
set relationship= null
where relationship='';

select * from login_activity;

update login_activity
set login_status='Success'
where login_status='SUCCESS';

update login_activity
set login_status='Failed'
where login_status='FAILED';

select session_duration_sec from login_activity;

select session_duration_sec from login_activity
where session_duration_sec < 0;

ALTER TABLE login_activity
ADD COLUMN session_duration_status VARCHAR(20);

UPDATE login_activity
SET session_duration_status =
CASE
WHEN session_duration_sec < 0 THEN 'Invalid'
ELSE 'Valid'
END;

select * from transactions;

select * from transactions
where account_id is null;

select * from transactions
where beneficiary_id is null;

update transactions
set transaction_type='UPI'
where transaction_type='upi';

update transactions
set transaction_type='NEFT'
where transaction_type='neft';

update transactions
set transaction_type='IMPS'
where transaction_type='imps';

update transactions
set transaction_type='RTGS'
where transaction_type='Rtgs';

update transactions
set transaction_type='RTGS'
where transaction_type='rtgs';

select * from transactions
where amount<0;

alter table transactions
add column Amount_Status varchar(20);

alter table transactions
modify column Amount_Status varchar(20) after amount;

UPDATE transactions
SET Amount_Status =
CASE
WHEN amount < 0 THEN 'Negative'
ELSE 'Valid'
END;

update transactions
set channel='Mobile App'
where channel='mobile app';

update transactions
set channel='ATM'
where channel='atm';

update transactions
set status='Failed'
where status='FAILED';

update transactions
set status='Success'
where status='success';

update transactions
set status='Pending'
where status='PENDING';

select * from transactions
where description= '';

update transactions
set description=null
where description= '';

select * from transactions;

update transactions
set description=trim(description);

select * from fraud_reports;

select * from fraud_reports
where fraud_type='phishing';

update fraud_reports
set fraud_type='Phishing'
where fraud_type= 'phishing';

update fraud_reports
set fraud_type= null
where fraud_type= '';

update fraud_reports
set reported_by= 'Customer'
where reported_by= 'customer';

update fraud_reports
set resolution_status= 'Pending'
where resolution_status= 'PENDING';

update fraud_reports
set resolution_status= 'Resolved'
where resolution_status= 'resolved';

update fraud_reports
set investigation_notes= null
where investigation_notes= '';

select * from fraud_reports
where investigation_notes= '';

update fraud_reports
set investigation_notes= trim(investigation_notes);

update fraud_reports
set amount_recovered= trim(amount_recovered);

select * from branches;
 
update branches
set branch_name=trim(branch_name);
 
update branches
set city=trim(city);
 
update branches 
set state=trim(state);

update branches 
set phone_status=trim(phone_status);

select * from customers;

update customers
set city=trim(city);

update customers
set kyc_status =trim(kyc_status);

select * from accounts;

update accounts
set account_status=trim(account_status);

select * from devices;

update devices
set is_trusted=trim(is_trusted);

select * from beneficiaries;

update beneficiaries
set relationship=trim(relationship);

select * from login_activity;

select * from transactions;

select beneficiary_id from transactions
where beneficiary_id is null;

select * from fraud_reports;

SELECT COUNT(*)
FROM transactions
WHERE beneficiary_id IS NULL;

update accounts
set account_type=Null
where account_type= '';

ALTER TABLE fraud_reports
ADD COLUMN recovery_flag VARCHAR(50) after amount_recovered;

UPDATE fraud_reports f
JOIN transactions t
ON f.transaction_id = t.transaction_id
SET f.recovery_flag =
CASE
WHEN f.amount_recovered = 0 THEN 'No Recovery'
WHEN f.amount_recovered > t.amount
THEN 'Recovery exceeds transaction amount'
ELSE 'OK'
END;

