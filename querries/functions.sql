-- first
CREATE OR REPLACE FUNCTION track_working_hours(
    employee_id integer,
    project_id integer,
    total_hours numeric
) RETURNS VOID AS $$
BEGIN
    -- Perform data validation here
    IF employee_id IS NULL OR project_id IS NULL OR total_hours IS NULL THEN
        RAISE EXCEPTION 'Invalid input: All parameters must be provided';
    END IF;
    
    -- Insert data into hour_tracking table
    INSERT INTO application.hour_tracking (employee_id, project_id, total_hours)
    VALUES (employee_id, project_id, total_hours);
END;
$$ LANGUAGE plpgsql;


--I modified the first parameters for now due to my employees_id is a bit higher than expected, but I will fix it.
SELECT track_working_hours(120, 7, 40.5);
SELECT track_working_hours(123, 7, 32.25);
SELECT track_working_hours(112, 7, 22.75);
