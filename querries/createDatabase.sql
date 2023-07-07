-- Table: application.titles

-- DROP TABLE IF EXISTS application.titles;

CREATE TABLE IF NOT EXISTS application.titles
(
    title_id integer NOT NULL DEFAULT nextval('application.titles_title_id_seq'::regclass),
    title_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.titles
    OWNER to admin;


-- Table: application.employees

-- DROP TABLE IF EXISTS application.employees;

CREATE TABLE IF NOT EXISTS application.employees
(
    "employees.id" integer NOT NULL DEFAULT nextval('application.employees_employee_id_seq'::regclass),
    first_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    hire_date date,
    hourly_salary numeric(10,2),
    title_id integer,
    manager_id integer,
    team_id integer,
    CONSTRAINT employees_pkey PRIMARY KEY ("employees.id"),
    CONSTRAINT team_id FOREIGN KEY (team_id)
        REFERENCES application.teams (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT title_id FOREIGN KEY (title_id)
        REFERENCES application.titles (title_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.employees
    OWNER to admin;


-- Table: application.teams

-- DROP TABLE IF EXISTS application.teams;

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

-- Table: application.projects

-- DROP TABLE IF EXISTS application.projects;

CREATE TABLE IF NOT EXISTS application.projects
(
    projects_id integer NOT NULL DEFAULT nextval('application.projects_projects_id_seq'::regclass),
    projects_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    client character varying(50) COLLATE pg_catalog."default" NOT NULL,
    start_date date,
    deadline date,
    CONSTRAINT projects_pkey PRIMARY KEY (projects_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.projects
    OWNER to admin;


-- Table: application.team_project

-- DROP TABLE IF EXISTS application.team_project;

CREATE TABLE IF NOT EXISTS application.team_project
(
    team_id integer,
    team_project integer,
    CONSTRAINT project_id FOREIGN KEY (team_project)
        REFERENCES application.projects (projects_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT team_id FOREIGN KEY (team_id)
        REFERENCES application.teams (team_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.team_project
    OWNER to admin;


-- Table: application.hour_tracking

-- DROP TABLE IF EXISTS application.hour_tracking;

CREATE TABLE IF NOT EXISTS application.hour_tracking
(
    employee_id integer,
    project_id integer,
    total_hours integer,
    CONSTRAINT employee_id FOREIGN KEY (employee_id)
        REFERENCES application.employees ("employees.id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT project_id FOREIGN KEY (project_id)
        REFERENCES application.projects (projects_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS application.hour_tracking
    OWNER to admin;