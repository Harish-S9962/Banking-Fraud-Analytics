use fraud;

---“Which device types are most commonly used by customers?”--;

SELECT device_type, COUNT(*) AS total_devices
FROM devices
GROUP BY device_type
ORDER BY total_devices DESC;

---“Which customers are using multiple devices?”--;

SELECT customer_id,COUNT(DISTINCT device_id) AS device_count
FROM devices
GROUP BY customer_id
HAVING COUNT(DISTINCT device_id) > 1
ORDER BY device_count DESC;

---How many trusted devices are there?--;

SELECT COUNT(*) AS trusted_devices
FROM devices
WHERE is_trusted = 'Yes';

---How many Untrusted devices are there?--;

SELECT COUNT(*) AS trusted_devices
FROM devices
WHERE is_trusted = 'No';

---Which location are not trusted?--;

SELECT l.location,COUNT(*) AS not_trusted_devices
FROM login_activity l
JOIN devices d
ON l.device_id = d.device_id
WHERE d.is_trusted = 'No'
GROUP BY l.location
ORDER BY not_trusted_devices DESC;

--Which customer use multiple device?;

SELECT customer_id,COUNT(DISTINCT device_id) AS total_devices
FROM devices
GROUP BY customer_id
HAVING COUNT(DISTINCT device_id) > 1
ORDER BY total_devices DESC;

--Which customers are using devices from not trusted location?--;

SELECT DISTINCT d.customer_id,l.location
FROM devices d
JOIN login_activity l
ON d.device_id = l.device_id
WHERE d.is_trusted = 'No';

--What types of devices and operating system are used by customers--;

SELECT DISTINCT device_type,operating_system
FROM devices
ORDER BY device_type, operating_system;

--Which customer device_id is failed to login more than 2 times?;

SELECT customer_id,device_id,
COUNT(*) AS failed_login
FROM login_activity
WHERE login_status = 'Failed'
GROUP BY customer_id, device_id
HAVING COUNT(*)>1
ORDER BY failed_login DESC;

--How many customers are logged succesfully--;

SELECT COUNT(*) AS successful_logins
FROM login_activity
WHERE login_status = 'Success';


--Customers who login_status is successful mor than 1 time--;

SELECT customer_id,
       COUNT(*) AS successful_login_count
FROM login_activity
WHERE login_status = 'Success'
GROUP BY customer_id
HAVING COUNT(*) >1
ORDER BY successful_login_count DESC;

--Which location is failed to login?--;

SELECT location,COUNT(*) AS failed_login_count
FROM login_activity
WHERE login_status = 'Failed'
GROUP BY location
ORDER BY failed_login_count DESC;

--Top 10 in not trusted location.--;

SELECT l.location,COUNT(*) AS not_trusted_count
FROM login_activity l JOIN devices d
ON l.device_id = d.device_id
WHERE d.is_trusted = 'No'
GROUP BY l.location
ORDER BY not_trusted_count DESC
LIMIT 10;

---Which customer has highest to failed login--;

SELECT customer_id,COUNT(*) AS failed_login_count
FROM login_activity
WHERE login_status = 'Failed'
GROUP BY customer_id
ORDER BY failed_login_count DESC
LIMIT 1;


