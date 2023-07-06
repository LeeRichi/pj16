--create tables
-- create titles table 
CREATE TABLE IF NOT EXISTS application.titles
(
    title_id integer NOT NULL DEFAULT nextval('application.titles_title_id_seq'::regclass),
    title_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.titles
    OWNER to admin;

--create employees table
CREATE TABLE IF NOT EXISTS application.employees
(
    employee_id integer NOT NULL DEFAULT nextval('application.employees_employee_id_seq'::regclass),
    employee_name character varying COLLATE pg_catalog."default" NOT NULL,
    title_id integer,
    manager_id integer,
    CONSTRAINT employees_pkey PRIMARY KEY (employee_id),
    CONSTRAINT manager_id FOREIGN KEY (manager_id)
        REFERENCES application.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT title_id FOREIGN KEY (title_id)
        REFERENCES application.titles (title_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.employees
    OWNER to admin;


-- create teams
CREATE TABLE IF NOT EXISTS application.teams
(
    team_id integer NOT NULL DEFAULT nextval('application.teams_team_id_seq'::regclass),
    team_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    location character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT teams_pkey PRIMARY KEY (team_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.teams
    OWNER to admin;

-- create projects
CREATE TABLE IF NOT EXISTS application.projects
(
    project_id integer NOT NULL DEFAULT nextval('application.projects_project_id_seq'::regclass),
    project_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    client character varying(50) COLLATE pg_catalog."default" NOT NULL,
    start_date date,
    deadline date,
    manager_id integer,
    CONSTRAINT projects_pkey PRIMARY KEY (project_id),
    CONSTRAINT manager_id FOREIGN KEY (manager_id)
        REFERENCES application.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.projects
    OWNER to admin;

-- create team_project
CREATE TABLE IF NOT EXISTS application.team_project
(
    team_id integer NOT NULL DEFAULT nextval('application.team_project_team_id_seq'::regclass),
    project_id integer NOT NULL DEFAULT nextval('application.team_project_project_id_seq'::regclass),
    CONSTRAINT project_id FOREIGN KEY (project_id)
        REFERENCES application.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT team_id FOREIGN KEY (team_id)
        REFERENCES application.teams (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.team_project
    OWNER to admin;

-- create hour_tracking table
CREATE TABLE IF NOT EXISTS application.hour_tracking
(
    employee_id integer,
    project_id integer,
    -- total_hours integer,
    -- not sure float or integer
    total_hours float,
    CONSTRAINT employee_id FOREIGN KEY (employee_id)
        REFERENCES application.employees (employee_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT project_id FOREIGN KEY (project_id)
        REFERENCES application.projects (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.hour_tracking
    OWNER to admin;