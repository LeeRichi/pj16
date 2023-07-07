-- first
CREATE OR REPLACE FUNCTION track_working_hours(
    employee_id integer,
    project_id integer,
    total_hours numeric
) RETURNS VOID AS $$
BEGIN
    IF employee_id IS NULL OR project_id IS NULL OR total_hours IS NULL THEN
        RAISE EXCEPTION 'Invalid input: All parameters must be provided';
    END IF;
    
    INSERT INTO application.hour_tracking (employee_id, project_id, total_hours)
    VALUES (employee_id, project_id, total_hours);
END;
$$ LANGUAGE plpgsql;


SELECT track_working_hours(120, 7, 40.5);
SELECT track_working_hours(123, 7, 32.25);
SELECT track_working_hours(112, 7, 22.75);




--second
DROP FUNCTION IF EXISTS create_project_with_teams(character varying, character varying, date, date, integer[]);

CREATE OR REPLACE FUNCTION create_project_with_teams(
    project_name character varying,
    client character varying,
    start_date date,
    deadline date,
    team_ids integer[]
) RETURNS INTEGER AS $$
DECLARE
    project_id INTEGER;
    team_id INTEGER;
BEGIN
    INSERT INTO application.projects (projects_name, client, start_date, deadline)
    VALUES (project_name, client, start_date, deadline)
    RETURNING projects_id INTO project_id;
    
    FOREACH team_id IN ARRAY team_ids LOOP
        INSERT INTO application.team_project (team_id, project_id)
        VALUES (team_id, project_id);
    END LOOP;
    
    RETURN project_id;
END;
$$ LANGUAGE plpgsql;

-- Execute the function
SELECT create_project_with_teams(
    'Mega Project',
    'Client Rich',
    '2099-12-31',
    '2100-12-31',
    ARRAY[1, 2, 3]
);
