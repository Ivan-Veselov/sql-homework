SET search_path=public; -- I don't know what it means

CREATE OR REPLACE FUNCTION GenerateData() RETURNS VOID AS $$
BEGIN

  -- building_types
  INSERT INTO building_types(type)
    SELECT unnest(ARRAY['Hotel', 'Swimming pool', 'Sports complex', 'Office', 'Pump track']);

  -- buildings
  INSERT INTO buildings(street, house_number, name, type_id) VALUES
    ('Toreza', 37, 'Super dormitory', 1),                -- 1
    ('Kantemirovskaya', 2, 'Times', 4),                  -- 2
    ('Pushkina', 239, 'Park inn', 1),                    -- 3
    ('Rayevskogo', 16, 'Alexeevsky', 3),                 -- 4
    ('Toreza', 7, 'Bike Park Fire Wheel', 5),            -- 5
    ('Khlopina', 8, 'PTS pool', 2),                      -- 6
    ('Universitetskaya', 7, 'Universe', 4),              -- 7
    ('Kronversky', 49, 'ITMO', 4),                       -- 8
    ('Politekhnicheskaya', 31, 'Pirogoviy Dvorik', 4),   -- 9
    ('Truda', 16, 'Hostel Orion', 1);                    -- 10

  -- countries
  INSERT INTO countries(name)
    SELECT unnest(ARRAY['Russia', 'Ukraine', 'USA', 'Germany']);

  -- sports
  INSERT INTO sports(name)
    SELECT unnest(ARRAY['Mountain biking', 'Synchronized swimming', 'Greco-Roman wrestling', 'Table tennis']);


  -- buildings_specializations
  INSERT INTO building_specializations(sport_id, building_id) VALUES
    (1, 5), (2, 4), (2, 6), (3, 6), (4, 4);

  -- delegations
  INSERT INTO delegations(country_id, headquarters_id) VALUES
    (1, 1), (2, 2), (3, 7), (4, 7);

  -- delegations_leaders
  INSERT INTO delegation_leaders(name, telephone_number, delegation_id) VALUES
    ('Alexander Omelchenko', '+7 (812) 448-85-94', 1),
    ('Taras Bulba', '+7 911 131-13-89', 2),
    ('Bill Poucher', '+1 (254) 710-3869', 3),
    ('Angela Merkel', '+4 420 052-45-05', 4);

  -- competitions TODO

  -- vehicles TODO

  -- assignments TODO

  -- volunteers
  INSERT INTO volunteers(name, telephone_number) VALUES
    ('Jean-Paul Sartre', '+7 42 1905-1980'),
    ('Soren Kierkegaard', '+1 12 1813-1855'),
    ('Albert Camus', '+2 07 1913-1960'),
    ('Martin Heidegger', '+4 77 1889-1976'),
    ('Friedrich Nietzsche', '+4 12 1844-1900'),
    ('Gabriel Marcel', '+5 11 1889-1973'),
    ('Michel Foucault', '+2 75 1926-1984'),
    ('Jean Baudrillard', '+1 05 1929-2007'),
    ('Jacques Derrida', '+3 87 1930-2004'),
    ('Georges Bataille', '+3 20 1897-1962');



  -- volunteers_assignments TODO

  -- athletes
  INSERT INTO athletes(name, sex, height, weight, age, accomodation_id, delegation_id, volunteer_id) VALUES
      ('Ginger Flores',    'female', 168, 60, 24, 1,  1, 1),
      ('Tasha Holt',       'female', 159, 55, 19, 1,  1, 1),
      ('Erin Lee',         'male',   170, 70, 30, 3,  4, 2),
      ('Lindsay Long',     'female', 165, 60, 25, 3,  4, 2),
      ('Sherri Simon',     'male',   168, 65, 28, 3,  4, 2),
      ('Milton Cruz',      'male',   180, 76, 17, 3,  2, 4),
      ('Eleanor Rivera',   'female', 170, 58, 28, 1,  2, 4),
      ('Don Moody',        'male',   185, 80, 21, 1,  2, 2),
      ('Howard Craig',     'male',   192, 81, 26, 1,  3, 8),
      ('Julius Torres',    'female', 165, 65, 23, 1,  3, 8),
      ('Tyrone Morgan',    'male',   170, 58, 27, 10, 3, 8),
      ('Cary Barnes',      'female', 173, 75, 34, 10, 3, 8),
      ('Pete Barker',      'male',   186, 82, 32, 10, 1, 3),
      ('Sylvia Richards',  'female', 158, 76, 19, 10, 1, 3),
      ('Austin Rose',      'male',   176, 70, 27, 3,  4, 3),
      ('Emmett Nunez',     'female', 170, 61, 20, 3,  4, 3),
      ('Bruce Weaver',     'male',   163, 52, 25, 3,  4, 2),
      ('Kenny Ballard',    'male',   180, 78, 27, 1,  1, 5),
      ('Shannon Fields',   'male',   182, 72, 25, 1,  1, 5),
      ('Lee Chapman',      'male',   174, 70, 23, 10, 2, 5);

  -- athletes_specializations TODO

  -- participations TODO

END;
$$ LANGUAGE plpgsql;

SELECT GenerateData();

