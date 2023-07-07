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



