-- TODO: default values - think about it

CREATE TYPE SEX AS ENUM ('male', 'female');

CREATE TABLE vehicles (
    id          SERIAL        PRIMARY KEY,
    reg_number  TEXT          NOT NULL UNIQUE,
    capacity    INTEGER       CHECK (capacity > 0) NOT NULL
);

CREATE TABLE assignments (
    id           SERIAL     PRIMARY KEY,
    timestamp    TIMESTAMP  NOT NULL,
    description  TEXT       NOT NULL,
    vehicle_id   INTEGER    REFERENCES vehicles NULL
);

CREATE TABLE volunteers (
    id                SERIAL   PRIMARY KEY,
    name              TEXT     NOT NULL,
    telephone_number  TEXT     NOT NULL,
    card_number       INTEGER  NOT NULL UNIQUE 
);

CREATE TABLE buildings (
    id            SERIAL   PRIMARY KEY,
    street        TEXT     NOT NULL,
    house_number  INTEGER  NOT NULL,
    type          TEXT     NOT NULL,
    name          TEXT     NULL 
);

CREATE TABLE delegations (
    id               SERIAL   PRIMARY KEY,
    country          TEXT     NOT NULL,
    headquarters_id  INTEGER  REFERENCES buildings NOT NULL
);

CREATE TABLE delegation_leaders (
    name              TEXT     NOT NULL,
    telephone_number  TEXT     NOT NULL,
    delegation_id     INTEGER  REFERENCES delegations NOT NULL
);

CREATE TABLE athletes (
    id               SERIAL   PRIMARY KEY,
    name             TEXT     NOT NULL,
    sex              SEX      NOT NULL,
    height           INTEGER  CHECK (height > 0) NOT NULL,
    weight           INTEGER  CHECK (weight > 0) NOT NULL,
    age              INTEGER  CHECK (age > 0) NOT NULL, 
    accomodation_id  INTEGER  REFERENCES buildings NULL,
    card_number      INTEGER  NOT NULL UNIQUE,
    delegation_id    INTEGER  REFERENCES delegations NOT NULL,
    volunteer_id     INTEGER  REFERENCES volunteers NULL
);

CREATE TABLE sports (
    id    SERIAL  PRIMARY KEY,
    name  TEXT    NOT NULL UNIQUE
);

CREATE TABLE competitions (
    id           SERIAL     PRIMARY KEY,
    sport_id     INTEGER    REFERENCES sports NOT NULL,
    timestamp    TIMESTAMP  NOT NULL,
    description  TEXT       NOT NULL,
    site_id      INTEGER    REFERENCES buildings NOT NULL
);

CREATE TABLE participations (
    competition_id  INTEGER  REFERENCES competitions NOT NULL,
    athlete_id      INTEGER  REFERENCES athletes NOT NULL,
    place           INTEGER  CHECK (place > 0) NULL,
    
    UNIQUE (competition_id, athlete_id),
    UNIQUE (competition_id, place)
);

CREATE TABLE athletes_specializations (
    athlete_id  INTEGER  REFERENCES athletes NOT NULL,
    sport_id    INTEGER  REFERENCES sports NOT NULL
);

CREATE TABLE building_specializations (
    building_id  INTEGER  REFERENCES buildings NOT NULL,
    sport_id     INTEGER  REFERENCES sports NOT NULL
);

CREATE TABLE volunteers_assignments (
    volunteer_id   INTEGER  REFERENCES volunteers NOT NULL,
    assignment_id  INTEGER  REFERENCES assignments NOT NULL
);
