CREATE TABLE titles (
  title_id INT PRIMARY KEY,
  title_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(50) NOT NULL,
  title_id INT,
  manager_id INT,
  FOREIGN KEY (title_id) REFERENCES titles(title_id),
  FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE teams (
  team_id INT PRIMARY KEY,
  team_name VARCHAR(50) NOT NULL,
  location VARCHAR(50) NOT NULL
);

CREATE TABLE projects (
  project_id INT PRIMARY KEY,
  project_name VARCHAR(50) NOT NULL,
  client VARCHAR(50) NOT NULL,
  start_date DATE,
  deadline DATE
);

CREATE TABLE team_project (
  team_id INT,
  project_id INT,
  FOREIGN KEY (team_id) REFERENCES teams(team_id),
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE TABLE hour_tracking (
  employee_id INT,
  project_id INT,
  total_hours FLOAT,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
  FOREIGN KEY (project_id) REFERENCES projects(project_id)
);


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
