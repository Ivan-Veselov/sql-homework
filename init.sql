-- TODO: default values - think about it

CREATE TYPE colour AS ENUM ('gold', 'silver', 'bronze');
CREATE TYPE sex AS ENUM ('male', 'female');

CREATE TABLE vehicles (
    id          serial        PRIMARY KEY,
    reg_number  text          NOT NULL,
    capacity    integer       CHECK (capacity BETWEEN 1 AND 500) NOT NULL
);

CREATE TABLE assignments (
    id           serial   PRIMARY KEY,
    date         date     NOT NULL,
    time         time     NOT NULL,
    description  text     NOT NULL,
    vehicle_id   integer  REFERENCES vehicles (id) 
);

CREATE TABLE volunteers (
    id                serial   PRIMARY KEY,
    name              text     NOT NULL,
    telephone_number  text     NOT NULL,
    card_number       integer  NOT NULL 
);

CREATE TABLE buildings (
    id            serial   PRIMARY KEY,
    street        text     NOT NULL,
    house_number  integer  NOT NULL,
    type          text     NOT NULL,
    name          text 
);

CREATE TABLE delegations (
    id               serial   PRIMARY KEY,
    country          text     NOT NULL,
    headquarters_id  integer  REFERENCES buildings (id) NOT NULL
);

CREATE TABLE delegation_leaders (
    name              text     NOT NULL,
    telephone_number  text     NOT NULL,
    delegation_id     integer  REFERENCES delegations (id) NOT NULL
);

CREATE TABLE athletes (
    id               serial   PRIMARY KEY,
    name             text     NOT NULL,
    sex              sex      NOT NULL,
    height           integer  CHECK (height BETWEEN 50 AND 300) NOT NULL,
    weight           integer  CHECK (weight BETWEEN 10 AND 650) NOT NULL,
    age              integer  CHECK (age BETWEEN 2 AND 130) NOT NULL, 
    accomodation_id  integer  REFERENCES buildings (id) NOT NULL,
    card_number      integer  NOT NULL,
    delegation_id    integer  REFERENCES delegations (id) NOT NULL,
    volunteer_id     integer  REFERENCES volunteers (id) NOT NULL
);

CREATE TABLE competitions (
	id           serial   PRIMARY KEY,
	sport        text     NOT NULL,
    date         date     NOT NULL,
    time         time     NOT NULL,
    description  text     NOT NULL,
    site_id      integer  REFERENCES buildings (id) NOT NULL
);

CREATE TABLE participations (
    competition_id  integer  REFERENCES competitions (id) NOT NULL,
    athlete_id      integer  REFERENCES athletes (id) NOT NULL
);

CREATE TABLE medals (    
    athlete_id      integer  REFERENCES athletes (id) NOT NULL,
    competition_id  integer  REFERENCES competitions (id) NOT NULL,
    colour          colour   NOT NULL
);

CREATE TABLE athletes_specializations (
    athlete_id  integer  REFERENCES athletes (id) NOT NULL,
    sport       text     NOT NULL
);

CREATE TABLE building_specializations (
    building_id  integer  REFERENCES buildings (id) NOT NULL,
    sport        text     NOT NULL
);

CREATE TABLE volunteers_assignments (
    volunteer_id   integer  REFERENCES volunteers (id) NOT NULL,
    assignment_id  integer  REFERENCES assignments (id) NOT NULL
);
