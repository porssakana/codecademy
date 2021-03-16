SELECT *
FROM employees
LIMIT 10;

SELECT *
FROM projects
LIMIT 10;

SELECT *
FROM employees
WHERE current_project IS NULL;

SELECT project_name 
FROM projects
WHERE project_id NOT IN (
   SELECT current_project
   FROM employees
   WHERE current_project IS NOT NULL);

SELECT project_name
FROM projects
INNER JOIN employees 
  ON projects.project_id = employees.current_project
WHERE current_project IS NOT NULL
GROUP BY project_name
ORDER BY COUNT(employee_id) DESC
LIMIT 1;

/*What is the name of the project chosen by the most employees?*/

SELECT project_name
FROM projects
INNER JOIN employees 
  ON projects.project_id = employees.current_project
WHERE current_project IS NOT NULL
GROUP BY current_project
HAVING COUNT(current_project) > 1;

/*Which projects were chosen by multiple employees?*/

SELECT projects.project_name AS 'Project', 
  COUNT(employees.current_project) AS 'Popularity'
FROM projects
INNER JOIN employees
ON projects.project_id = employees.current_project
GROUP BY 1
ORDER BY 2 DESC;

/*When employees are hired at CVR, they are given the Myers-Briggs personality test.
We try to diminish tension among team members by creating teams based on compatible personalities.
The chart shows which personality matches should be avoided.
For example, an employee with the ISFP personality type should not be matched with an INFP, ENFP, or an INFJ.*/

SELECT (COUNT(*) * 2) - (
  SELECT COUNT(*)
  FROM employees
  WHERE current_project IS NOT NULL
    AND position = 'Developer') AS 'Count'
FROM projects;

/*Which personality is the most common across our employees?*/

SELECT personality 
FROM employees
GROUP BY personality
ORDER BY COUNT(personality) DESC
LIMIT 1;

/*What are the names of projects chosen by employees 
with the most common personality type?*/

SELECT project_name 
FROM projects
INNER JOIN employees 
  ON projects.project_id = employees.current_project
WHERE personality = (
   SELECT personality
   FROM employees
   GROUP BY personality
   ORDER BY COUNT(personality) DESC
   LIMIT 1);

/*Find the personality type most represented by employees with a selected project.
What are names of those employees, the personality type, 
and the names of the project they’ve chosen?*/

SELECT last_name, first_name, personality, project_name
FROM employees
INNER JOIN projects 
  ON employees.current_project = projects.project_id
WHERE personality = (
   SELECT personality 
   FROM employees
   WHERE current_project IS NOT NULL
   GROUP BY personality
   ORDER BY COUNT(personality) DESC
   LIMIT 1);

/*For each employee, provide their name, personality, the names of any projects they’ve chosen,
and the number of incompatible co-workers.*/

SELECT last_name, first_name, personality, project_name,
CASE 
   WHEN personality = 'INFP' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
   WHEN personality = 'ISFP' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('INFP', 'ENTP', 'INFJ'))
   WHEN personality = 'INFJ' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
   WHEN personality = 'ENFP' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ISFP', 'ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))   
   WHEN personality = 'ENFJ' 
   THEN (SELECT COUNT(*)
      FROM employees 
      WHERE personality IN ('ESFP', 'ISTP', 'ESTP', 'ISFJ', 'ESFJ', 'ISTJ', 'ESTJ'))
   ELSE 0
END AS 'Incompatible'
FROM employees
LEFT JOIN projects on employees.current_project = projects.project_id;
