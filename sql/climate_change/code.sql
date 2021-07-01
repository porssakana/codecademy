SELECT *
FROM state_climate
LIMIT 10;

/*Write a query that returns the state, year, tempf or tempc, and running_avg_temp (in either Celsius or Fahrenheit) for each state.

(The running_avg_temp should use a window function.)*/

SELECT state, year, tempc, AVG (tempc) OVER (
      PARTITION BY state 
      ORDER BY year
    ) AS 'running_avg_temp'
FROM state_climate
LIMIT 10;

/*Write a query that returns state, year, tempf or tempc, and the lowest temperature (lowest_temp) for each state.

Are the lowest recorded temps for each state more recent or more historic?*/

SELECT state, year, tempc, FIRST_VALUE (tempc) OVER (
      PARTITION BY state
      ORDER BY tempc
   ) AS 'lowest temp'
FROM state_climate
LIMIT 10;

SELECT state, year, tempc, LAST_VALUE (tempc) OVER ( 
      PARTITION BY state
      ORDER BY tempc
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
   ) AS 'highest_temp'
FROM state_climate
LIMIT 10;

/*Write a query to select the same columns but now you should write a window function that returns the change_in_temp from the previous year (no null values should be returned).*/

SELECT state, year, tempc, tempc - LAG(tempc, 1, tempc) OVER (PARTITION BY state ORDER BY year) AS 'change_in_temps'
FROM state_climate
ORDER BY 'change_in_temps' DESC
LIMIT 10;

/*Write a query to return a rank of the coldest temperatures on record (coldest_rank) along with year, state, and tempf or tempc. Are the coldest ranked years recent or historic? The coldest years should be from any state or year.*/

SELECT RANK() OVER (ORDER BY tempc) AS 'coldest_rank', state, year, tempc
FROM state_climate 
LIMIT 10;

/*Modify your coldest_rank query to now instead return the warmest_rank for each state, meaning your query should return the warmest temp/year for each state. Again, are the warmest temperatures more recent or historic for each state?*/

SELECT RANK() OVER (ORDER BY tempc DESC) AS 'warmest_rank', state, year, tempc
FROM state_climate 
LIMIT 10;

/*Let’s now write a query that will return the average yearly temperatures in quartiles instead of in rankings for each state.
Your query should return quartile, year, state and tempf or tempc. The top quartile should be the coldest years.*/

SELECT NTILE(4) OVER (PARTITION BY state ORDER BY tempc) AS 'quartile', year, state, tempc
FROM state_climate
LIMIT 10;

/*Lastly, we will write a query that will return the average yearly temperatures in quintiles (5).
Your query should return quintile, year, state and tempf or tempc. The top quintile should be the coldest years overall, not by state.*/

SELECT NTILE(5) OVER (ORDER BY tempc) AS 'quintile', year, state, tempc
FROM state_climate
LIMIT 10;
