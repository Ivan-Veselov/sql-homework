CREATE TYPE colour AS ENUM ('gold', 'silver', 'bronze');
CREATE TYPE sex AS ENUM ('male', 'female');

CREATE TABLE vehicles (
    id serial PRIMARY KEY,
    reg_number text,
    capacity integer
);

CREATE TABLE assignments (
    id serial PRIMARY KEY,
    date date,
    time time,
    description text,
    vehicle_id integer REFERENCES vehicles (id)
);

CREATE TABLE volunteers (
    id serial PRIMARY KEY,
    name text,
    telephone_number text,
    card_number integer
);

CREATE TABLE buildings (
    id serial PRIMARY KEY,
    street text,
    house_number integer,
    type text,
    name text
);

CREATE TABLE delegations (
    id serial PRIMARY KEY,
    country text,
    headquarters_id integer REFERENCES buildings (id)
);

CREATE TABLE delegationLeaders (
    name text,
    telephone_number text,
    delegation_id integer REFERENCES delegations (id)
);

CREATE TABLE athletes (
    id serial PRIMARY KEY,
    name text,
    sex sex,
    height integer CHECK (height BETWEEN 50 AND 300),
    weight integer CHECK (weight BETWEEN 10 AND 650),
    age integer, --TODO
    accomodation_id integer REFERENCES buildings (id),
    card_number integer,
    delecation_id integer REFERENCES delegations (id),
    volunteer_id integer REFERENCES volunteers (id)
);

CREATE TABLE competitions (
	id serial PRIMARY KEY,
	sport text,
    date date,
    time time,
    description text,
    site_id integer REFERENCES buildings (id)
);

CREATE TABLE participations (
    competition_id integer REFERENCES competitions (id),
    athlete_id integer REFERENCES athletes (id)
);

CREATE TABLE medals (    
    athlete_id integer REFERENCES athletes (id),
    competition_id integer REFERENCES competitions (id),
    colour colour
);

CREATE TABLE athletesSpecializations (
    athlete_id integer REFERENCES athletes (id),
    sport text
);

CREATE TABLE buildingSpecializations (
    building_id integer REFERENCES buildings (id),
    sport text
);

CREATE TABLE volunteersAssignments (
    volunteer_id integer REFERENCES volunteers (id),
    assignment_id integer REFERENCES assignments (id)
);
