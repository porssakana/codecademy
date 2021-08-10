/* Coding Challenge 1
The books table has the following columns:

id - the book id
title - the book title
author - the book author
average_rating - the average rating
num_pages - the number of pages */

-- Select the title, author, and average_rating of each book with an average_rating between 3.5 and 4.5.

SELECT title, author, average_rating
FROM books 
WHERE average_rating
BETWEEN 3.5 AND 4.5;

-- Select all the unique authors from the table.

SELECT DISTINCT author
FROM books;

---------------------------------------------------
/* Code Challenge 2
The nba_matches table has the following columns:

id - the match id
date - the date of the match
home_team - the home team
away_team - the away team
home_points - the home team points
away_points - the away team points */

/* Given the final scores of several NBA games, use CASE to return the results for each game:

If home team won, return ‘HOME WIN’.
If away team won, return ‘AWAY WIN’.
Select the id column and the CASE result. */

SELECT id, 
  CASE
    WHEN home_points > away_points 
      THEN 'HOME WIN'
    ELSE 'AWAY WIN'
  END
FROM nba_matches;

---------------------------------------------------
/* Code Challenge 3
The apps table has the following columns:

id - the app id
name - the app name
genre - the genre of the app
rating - the app rating
reviews - the number of reviews */

/* Get the total number of reviews of all apps by genre.

Limit the results for genres where the total number of app reviews is over 30 million. */

SELECT genre, SUM(reviews)
FROM apps
GROUP BY genre
HAVING SUM(reviews) > 30000000;

---------------------------------------------------
/* Code Challenge 4
The apps table has the following columns:

id - the app id
name - the app name
genre - the genre of the app
rating - the app rating
reviews - the number of reviews */

--Select the name, genre, and rating of apps in descending order of their rating, and limit the result to 20 rows.

SELECT name, genre, rating
FROM apps
ORDER BY rating DESC 
LIMIT 20;

---------------------------------------------------
/* Code Challenge 5
The apps table has the following columns:

id - the app id
name - the app name
genre - the genre of the app
rating - the app rating
reviews - the number of reviews */

--Get the average rating of all apps, rounded to 2 decimal places. Alias the result column as ‘average rating’.

SELECT ROUND(AVG(rating), 2)
FROM apps;

---------------------------------------------------
/* Code Challenge 6
The projects table has the following columns:

id - the project id
employee_id - the id of the employee assigned to this project
The employees table has the following columns:

id - the id of the employee
first_name - the first name of the employee
last_name - the last name of the employee */

--Perform a join between the two tables, such that it selects all projects even if there is no employee assigned to it.

SELECT *
FROM projects
LEFT JOIN employees
  ON projects.employee_id = employees.id;

---------------------------------------------------
/* Code Challenge 7
The math_students and english_students tables have the following columns:

student_id - the student id
grade - the grade level of the student
first_name - the student’s first name
last_name - the student’s last name */

--Using a subquery, find out which students in math are in the same grade level as the student with id 7.

SELECT *
FROM math_students
WHERE grade IN (
  SELECT grade
  FROM math_students
  WHERE student_id =7
);

---------------------------------------------------
/* Code Challenge 8
The math_students and english_students tables have the following columns:

student_id - the student id
grade - the grade level of the student
first_name - the student’s first name
last_name - the student’s last name */

--Using a subquery, find out what grade levels are represented in both the math and english classes.

SELECT grade
FROM math_students
WHERE EXISTS (
  SELECT grade
  FROM english_students
);

---------------------------------------------------
/* Code Challenge 9
The box_office table has the following columns:

id - the id of each row
title - the title of the movie
week - the week following the film’s release
gross - the gross for that week
to_date_gross - the total gross of the movie up to each week */

--Using a window function with PARTITION BY, get the total change in gross for each movie up to the current week and display it next to the current week column along with the title, week, and gross columns.

SELECT title, week, gross, 
SUM(gross) OVER (
  PARTITION BY title 
  ORDER BY week
  ) AS 'running_total_gross'
FROM box_office;

---------------------------------------------------
/* Code Challenge 10
The box_office table has the following columns:

id - the id of each row
title - the title of the movie
week - the week following the film’s release
gross - the gross for that week
to_date_gross - the total gross of the movie up to each week */

--Write a query using a window function with ROW_NUMBER and ORDER BY to see where each row falls in the amount of gross.

SELECT ROW_NUMBER()
OVER (
  ORDER BY gross
) AS 'row_num', title, week, gross
FROM box_office;

---------------------------------------------------
/* Code Challenge 11
The orders table has the following columns:

id - the order id
product_id - the product id
price - the price of the individual product item
quantity - the quantity of items in the order */

--Given an orders table, calculate the price times quantity of each order. Include the id and product_id columns in the result.

SELECT id, product_id, price*quantity AS 'total'
FROM orders;

---------------------------------------------------
/* Code Challenge 12
The weather table has the following columns:

id - the id of each entry
date - the date of each entry
high - the high temperature of the date, in Fahrenheit
low - the low temperature of the date, in Fahrenheit */

/* Utilize CAST to calculate the average of the low and high temperatures for each date such that the result is of type REAL.

Select the date column and alias this result column as ‘average’. */

SELECT date, (CAST(high AS 'REAL') + 
  CAST(low AS 'REAL')) / 2.0 AS 'average'
FROM weather;

---------------------------------------------------
/* Code Challenge 12
The weather table has the following columns:

id - the id of each entry
date - the date of each entry
high - the high temperature of the date, in Fahrenheit
low - the low temperature of the date, in Fahrenheit */

/* Utilize CAST to calculate the average of the low and high temperatures for each date such that the result is of type REAL.

Select the date column and alias this result column as ‘average’. */

SELECT date, (CAST(high AS 'REAL') + 
  CAST(low AS 'REAL')) / 2.0 AS 'average'
FROM weather;

---------------------------------------------------
/* Code Challenge 13
The purchases table has the following columns:

purchase_id - the id of the purchase
purchase_date - the date of the purchase */

/* After a purchase is created, it can be returned within 7 days for a full refund.

Using modifiers, get the date of each purchase offset by 7 days in the future. */

SELECT purchase_id, DATE(purchase_date, '+7 days')
FROM purchases;

/* Get the hour that each purchase was made.

Which hour had the most purchases made? */ 

SELECT STRFTIME('%H', purchase_date)
FROM purchases;

---------------------------------------------------
/* Code Challenge 14
The purchases table has the following columns:

purchase_id - the id of the purchase
purchase_date - the date of the purchase */

/* Using string formatting and substitutions, get the month and day for each purchase in the form ‘mm-dd’.

Give this new column a name of ‘reformatted’. */

SELECT STRFTIME('%m-%d', purchase_date) AS 'reformatted'
FROM purchases;



