-- Retrieve the team names and their corresponding project count.
SELECT teams.team_name, COUNT(team_project.team_project) AS project_count
FROM application.teams
LEFT JOIN application.team_project ON teams.team_id = team_project.team_id
GROUP BY teams.team_name;


-- Retrieve the projects managed by the managers whose first name starts with "J" or "D".
SELECT projects.projects_name, CONCAT(employees.first_name, ' ', employees.last_name) AS employee_name
FROM application.projects
JOIN application.employees ON projects.projects_id = employees.manager_id
WHERE employees.first_name LIKE 'J%' OR employees.first_name LIKE 'D%';


-- Retrieve all the employees (both directly and indirectly) working under Andrew Martin
WITH RECURSIVE employee_tree AS (
  SELECT "employees.id", first_name, last_name, manager_id
  FROM application.employees
  WHERE first_name <> 'Andrew' OR last_name <> 'Martin'
  UNION ALL
  SELECT e."employees.id", e.first_name, e.last_name, e.manager_id
  FROM application.employees e
  JOIN employee_tree et ON e.manager_id = et."employees.id"
)
SELECT *
FROM employee_tree;

-- Retrieve all the employees (both directly and indirectly) working under Robert Brown:
WITH RECURSIVE employee_tree AS (
  SELECT "employees.id", first_name, last_name, manager_id
  FROM application.employees
  WHERE first_name <> 'Robert' OR last_name <> 'Brown'
  UNION ALL
  SELECT e."employees.id", e.first_name, e.last_name, e.manager_id
  FROM application.employees e
  JOIN employee_tree et ON e.manager_id = et."employees.id"
)
SELECT *
FROM employee_tree;


-- Retrieve the average hourly salary for each title:
SELECT titles.title_name, AVG(employees.hourly_salary) AS average_hourly_salary
FROM application.employees
JOIN application.titles ON employees.title_id = titles.title_id
GROUP BY titles.title_name;


-- Retrieve the employees who have a higher hourly salary than their respective team's average hourly salary:
SELECT employees.first_name, employees.last_name, employees.team_id
FROM application.employees
JOIN application.teams ON employees.team_id = teams.team_id
JOIN (
  SELECT team_id, AVG(hourly_salary) AS average_hourly_salary
  FROM application.employees
  GROUP BY team_id
) AS team_avg ON employees.team_id = team_avg.team_id
WHERE employees.hourly_salary > team_avg.average_hourly_salary;


-- Retrieve the projects that have more than 3 teams assigned to them:
SELECT projects.projects_name, ARRAY_AGG(teams.team_name) AS team_list
FROM application.projects
JOIN (
  SELECT project_id, COUNT(team_id) AS team_count
  FROM application.team_project
  GROUP BY project_id
  HAVING COUNT(team_id) > 3
) AS project_teams ON projects.projects_id = project_teams.project_id
JOIN application.team_project ON projects.projects_id = application.team_project.project_id
JOIN application.teams ON application.teams.team_id = application.team_project.team_id
GROUP BY projects.projects_name;


-- Retrieve the total hourly salary expense for each team:
SELECT teams.team_name, SUM(employees.hourly_salary) AS total_hourly_salary
FROM application.teams
JOIN application.employees ON teams.team_id = employees.team_id
GROUP BY teams.team_name;





