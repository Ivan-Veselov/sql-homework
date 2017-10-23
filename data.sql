SET search_path=public; -- I don't know what it means

CREATE OR REPLACE FUNCTION GenerateData() RETURNS VOID AS $$
BEGIN

PERFORM setseed(0.42);

-- building_types
INSERT INTO building_types(type)
  SELECT unnest(ARRAY['Hotel', 'Swimming pull', 'Sports complex', 'Office', 'Catering', 'Pump track']);

-- buildings
WITH Addresses AS (
    SELECT street, number, row_number() OVER () as id
    FROM
      unnest(ARRAY['Toreza', 'Kurchatova', 'Yakovskaya', 'Shatelena', 'Politechnicheskaya', 'Pushkina'])
        AS street
      CROSS JOIN
      generate_series(1, 10) AS number
), BuildingNames AS (
    SELECT name, row_number() OVER () AS id
    FROM
      unnest(ARRAY['Tibedied', 'Qube', 'Leleer', 'Biarge', 'Xequerin', 'Tiraor', 'Rabedira', 'Lave', 'Zaatxe', 'Diusreza', 'Teaatis', 'Riinus', 'Esbiza', 'Ontimaxe', 'Cebetela', 'Ceedra', 'Rizala', 'Atriso', 'Teanrebi', 'Azaqu', 'Retila', 'Sotiqu', 'Inleus', 'Onrira', 'Ceinzala', 'Biisza', 'Legees', 'Quator', 'Arexe', 'Atrabiin', 'Usanat', 'Xeesle', 'Oreseren', 'Inera', 'Inus', 'Isence', 'Reesdice', 'Terea', 'Orgetibe', 'Reorte', 'Ququor', 'Geinona', 'Anarlaqu', 'Oresri', 'Esesla', 'Socelage', 'Riedquat', 'Gerege', 'Usle', 'Malama', 'Aesbion', 'Alaza', 'Xeaqu', 'Raoror', 'Ororqu', 'Leesti', 'Geisgeza', 'Zainlabi', 'Uscela', 'Isveve', 'Tioranin', 'Learorce', 'Esusti', 'Ususor', 'Maregeis', 'Aate', 'Sori', 'Cemave', 'Arusqudi', 'Eredve', 'Regeatge', 'Edinso', 'Ra', 'Aronar', 'Arraesso', 'Cevege', 'Orteve', 'Geerra', 'Soinuste', 'Erlage', 'Xeaan', 'Veis', 'Ensoreus', 'Riveis', 'Bivea', 'Ermaso', 'Velete', 'Engema', 'Atrienxe', 'Beusrior', 'Ontiat', 'Atarza', 'Arazaes', 'Xeeranre', 'Quzadi', 'Isti', 'Digebiti', 'Leoned', 'Enzaer', 'Teraed', 'Vetitice', 'Laenin', 'Beraanxe', 'Atage', 'Veisti', 'Zaerla', 'Esredice', 'Beor', 'Orso', 'Usatqura', 'Erbiti', 'Reinen', 'Ininbi', 'Erlaza', 'Celabile', 'Ribiso', 'Qudira', 'Isdibi', 'Gequre', 'Rarere', 'Aerater', 'Atbevete', 'Bioris', 'Raale', 'Tionisla', 'Encereso', 'Anerbe', 'Gelaed', 'Onusorle', 'Zaonce', 'Diquer', 'Zadies', 'Entizadi', 'Esanbe', 'Usralaat', 'Anlere', 'Teveri', 'Sotiera', 'Ededleen', 'Inonri', 'Esbeus', 'Lerelace', 'Eszaraxe', 'Anbeen', 'Biorle', 'Anisor', 'Usrarema', 'Diso', 'Riraes', 'Orrira', 'Xeer', 'Ceesxe', 'Isatre', 'Aona', 'Isinor', 'Uszaa', 'Aanbiat', 'Bemaera', 'Inines', 'Edzaon', 'Leritean', 'Veale', 'Edle', 'Anlama', 'Ribilebi', 'Relaes', 'Dizaoner', 'Razaar', 'Enonla', 'Isanlequ', 'Tibecea', 'Sotera', 'Esveor', 'Esteonbi', 'Xeesenri', 'Oresle', 'Ervein', 'Larais', 'Anxebiza', 'Diedar', 'Eninre', 'Bibe', 'Diquxe', 'Sorace', 'Anxeonis', 'Riantiat', 'Zarece', 'Maesin', 'Tibionis', 'Gelegeus', 'Diora', 'Rigeti', 'Begeabi', 'Orrere', 'Beti', 'Gerete', 'Qucerere', 'Xeoner', 'Xezaor', 'Ritila', 'Edorte', 'Zaalela', 'Biisorte', 'Beesor', 'Oresqu', 'Xeququti', 'Maises', 'Bierle', 'Arzaso', 'Teen', 'Riredi', 'Teorge', 'Vebege', 'Xeenle', 'Arxeza', 'Edreor', 'Esgerean', 'Ditiza', 'Anle', 'Onisqu', 'Aleusqu', 'Zasoceat', 'Rilace', 'Beenri', 'Laeden', 'Mariar', 'Riiser', 'Qutiri', 'Biramabi', 'Soorbi', 'Solageon', 'Tiquat', 'Rexebe', 'Qubeen', 'Cetiisqu', 'Rebia', 'Ordima', 'Aruszati', 'Zaleriza', 'Zasoer', 'Raleen', 'Qurave', 'Atrebibi', 'Teesdi', 'Ararus', 'Ara', 'Tianve', 'Quorte', 'Soladies', 'Maxeedso', 'Xexedi', 'Xexeti', 'Tiinlebi', 'Rateedar', 'Onlema', 'Orerve'])
        AS name
)
INSERT INTO buildings(street, house_number, name, type_id)
    SELECT street, number, name,  (0.5 + random() * (SELECT COUNT(*) FROM building_types))::INT
    FROM BuildingNames B JOIN Addresses A ON B.id = A.id;

-- countries
INSERT INTO countries(name)
  SELECT unnest(ARRAY['Afghanistan', 'Albania', 'Algeria', 'Andorra', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan', 'Bahamas', 'Bahrain', 'Bangladesh', 'Barbados', 'Belarus', 'Belgium', 'Belize', 'Benin', 'Bhutan', 'Bolivia', 'Bosnia and Herzegovina', 'Botswana', 'Brazil', 'Brunei', 'Bulgaria', 'Burkina Faso', 'Burundi', 'Cabo Verde', 'Cambodia', 'Cameroon', 'Canada', 'Central African Republic', 'Chad', 'Chile', 'China', 'Colombia', 'Comoros', 'Democratic Republic of the Congo', 'Republic of the Congo', 'Costa Rica', E'Cote d\'Ivoire', 'Croatia', 'Cuba', 'Cyprus', 'Czech Republic', 'Denmark', 'Djibouti', 'Dominica', 'Dominican Republic', 'Ecuador', 'Egypt', 'El Salvador', 'Equatorial Guinea', 'Eritrea', 'Estonia', 'Ethiopia', 'Fiji', 'Finland', 'France', 'Gabon', 'Gambia', 'Georgia', 'Germany', 'Ghana', 'Greece', 'Grenada', 'Guatemala', 'Guinea', 'Guinea-Bissau', 'Guyana', 'Haiti', 'Honduras', 'Hungary', 'Iceland', 'India', 'Indonesia', 'Iran', 'Iraq', 'Ireland', 'Israel', 'Italy', 'Jamaica', 'Japan', 'Jordan', 'Kazakhstan', 'Kenya', 'Kiribati', 'Kosovo', 'Kuwait', 'Kyrgyzstan', 'Laos', 'Latvia', 'Lebanon', 'Lesotho', 'Liberia', 'Libya', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macedonia', 'Madagascar', 'Malawi', 'Malaysia', 'Maldives', 'Mali', 'Malta', 'Marshall Islands', 'Mauritania', 'Mauritius', 'Mexico', 'Micronesia', 'Moldova', 'Monaco', 'Mongolia', 'Montenegro', 'Morocco', 'Mozambique', 'Myanmar', 'Namibia', 'Nauru', 'Nepal', 'Netherlands', 'New Zealand', 'Nicaragua', 'Niger', 'Nigeria', 'North Korea', 'Norway', 'Oman', 'Pakistan', 'Palau', 'Palestine', 'Panama', 'Papua New Guinea', 'Paraguay', 'Peru', 'Philippines', 'Poland', 'Portugal', 'Qatar', 'Romania', 'Russia', 'Rwanda', 'Saint Kitts and Nevis', 'Saint Lucia', 'Saint Vincent and the Grenadines', 'Samoa', 'San Marino', 'Sao Tome and Principe', 'Saudi Arabia', 'Senegal', 'Serbia', 'Seychelles', 'Sierra Leone', 'Singapore', 'Slovakia', 'Slovenia', 'Solomon Islands', 'Somalia', 'South Africa', 'South Korea', 'South Sudan', 'Spain', 'Sri Lanka', 'Sudan', 'Suriname', 'Swaziland', 'Sweden', 'Switzerland', 'Syria', 'Taiwan', 'Tajikistan', 'Tanzania', 'Thailand', 'Timor-Leste', 'Togo', 'Tonga', 'Trinidad and Tobago', 'Tunisia', 'Turkey', 'Turkmenistan', 'Tuvalu', 'Uganda', 'Ukraine', 'United Arab Emirates (UAE)', 'United Kingdom (UK)', 'United States of America (USA)', 'Uruguay', 'Uzbekistan', 'Vanuatu', 'Vatican City', 'Venezuela', 'Vietnam', 'Yemen', 'Zambia', 'Zimbabwe']);

-- sports
-- TODO: больше sports богу sports
INSERT INTO sports(name)
  SELECT unnest(ARRAY['Mountain biking', 'Synchronized swimming', 'Greco-Roman wrestling', 'Table tennis']);


-- buildings_specializations
INSERT INTO building_specializations(sport_id, building_id)
  SELECT S.id, B.id
  FROM sports S CROSS JOIN buildings B
  ORDER BY random()
  LIMIT (SELECT COUNT(*) FROM buildings) * 2;

-- delegations
WITH PossibleHQ AS (
  SELECT B.id AS b_id, row_number() OVER () AS id
  FROM
    buildings B JOIN building_types T ON B.type_id = T.id
  WHERE T.type = 'Hotel' OR T.type = 'Office'
  ORDER BY random()
)
INSERT INTO delegations(country_id, headquarters_id)
  SELECT C.id, b_id
  FROM countries C JOIN PossibleHQ P ON C.id = P.id;

-- delegations_leaders
WITH Names AS (
  SELECT name, row_number() OVER () AS id
  FROM unnest(ARRAY['Громозека', 'Ким', 'Буран', 'Зелёный', 'Горбовский', 'Ийон Тихий', 'Форд Префект', 'Михаил Комов', 'Каммерер', 'Ким', 'Гагарин', 'Армстронг', 'Гленн', 'Леонов'])
    AS name
), Phones AS (
  SELECT phone, row_number() OVER () AS id
  FROM unnest(ARRAY['(379) 662-9283', '(707) 978-6090', '(494) 379-9610', '(326) 387-9599', '(901) 990-4462', '(660) 674-0306', '(839) 305-6616', '(664) 303-1204', '(452) 157-0050', '(461) 282-9723', '(590) 792-2320', '(857) 454-3422', '(824) 787-2640', '(488) 665-9441', '(874) 767-7121', '(254) 673-7048', '(411) 669-1384', '(787) 940-8061', '(510) 760-5791', '(755) 812-5537'])
    AS phone
)
INSERT INTO delegation_leaders(name, telephone_number, delegation_id)
  SELECT name, phone, (0.5 + random() * (SELECT COUNT(*) FROM Delegations))::INT
  FROM Names N JOIN Phones P ON N.id = P.id;

-- competitions
WITH Ids AS (
  SELECT generate_series(1, 500) AS id
), Descriptions AS (
  SELECT id, 'Competition description #' || id :: TEXT AS description
  FROM Ids
)
INSERT INTO competitions(sport_id, timestamp, description, site_id)
  SELECT
    (0.5 + random() * (SELECT COUNT(*) FROM Sports))::INT,
    timestamp '2017-06-01 10:00:00' +
      random() * (timestamp '2017-08-30 21:00:00' - timestamp '2017-06-01 10:00:00'),
    description,
    (0.5 + random() * (SELECT COUNT(*) FROM building_types))::INT -- todo: not office nor hostel
  FROM Descriptions;

-- vehicles
WITH Ids AS (
  SELECT generate_series(1, 200) AS id
), RegNumbers AS (
  SELECT id, 'K' || id :: Text || 'EK' AS reg_number
  FROM Ids
)
INSERT INTO vehicles(reg_number, capacity)
  SELECT reg_number, (0.5 + random() * 20)::INT
  FROM RegNumbers;

-- assignments
WITH Ids AS (
    SELECT generate_series(1, 500) AS id
), Descriptions AS (
    SELECT id, 'Assignment description #' || id :: TEXT AS description
    FROM Ids
)
INSERT INTO assignments(timestamp, description, vehicle_id)
  SELECT
    timestamp '2017-06-01 10:00:00' +
      random() * (timestamp '2017-08-30 21:00:00' - timestamp '2017-06-01 10:00:00'),
    description,
    (0.5 + random() * (SELECT COUNT(*) FROM vehicles))::INT
  FROM Descriptions;

-- volunteers
WITH Names AS (
    SELECT name, row_number() OVER () AS id
    FROM unnest(ARRAY['Cooper Evans', 'Taylor Holloway', 'Miguel Rhodes', 'Jaycee Duncan', 'Mateo Becker', 'Dereon Bowman', 'Carlo Russo', 'Elian Barajas', 'Celeste Mooney', 'Peter Black', 'Jovanni Gonzalez', 'Lyla Erickson', 'Norah Mack', 'Adan Bryant', 'Irvin Nguyen', 'Sergio Barron', 'Kolton Ortiz', 'Preston Glover', 'Dashawn Harrington', 'Cordell Aguilar', 'Karla Daniels', 'Ernest Pace', 'Ashleigh Spencer', 'Tanner Pacheco', 'Greta Garrett', 'Holden Pham', 'Luca Harding', 'Kaliyah Long', 'Ian Keller', 'Khalil Graham', 'Kristian Watson', 'Abigail Eaton', 'Jair Chung', 'Lewis Mccoy', 'Aubree Pratt', 'Kevin Dennis', 'Mauricio Jensen', 'Selah Skinner', 'Alissa Santana', 'Kellen Henderson', 'Luciano Herrera', 'Sheldon Sheppard', 'Genesis Burns', 'Sharon Munoz', 'Alena Mora', 'Axel Crosby', 'Chad Lee', 'Trenton Levy', 'Kelsey Fleming', 'Kadence Rollins'])
      AS name
), Persons AS (
    SELECT id, name, '+7 911 131-13-' || id :: TEXT AS phone
    FROM Names
)
INSERT INTO volunteers(name, telephone_number)
  SELECT name, phone
  FROM Persons;

-- volunteers_assignments
INSERT INTO volunteers_assignments(volunteer_id, assignment_id)
  SELECT V.id, A.id
  FROM volunteers V CROSS JOIN assignments A
  ORDER BY random()
  LIMIT (SELECT COUNT(*) FROM assignments) * 2;

-- athletes
WITH Names AS (
    SELECT name, row_number() OVER () AS id
    FROM unnest(ARRAY['Jazlene Gibbs', 'Callum Doyle', 'Branson Parks', 'Parker Riddle', 'Alisa Kemp', 'Matias Waters', 'Jazlynn Maldonado', 'Adyson Nichols', 'Terrence Tyler', 'Marissa Newman', 'Shayla Hester', 'Odin Crane', 'Roman Stewart', 'Abdiel Odonnell', 'Krystal Turner', 'Nickolas Brennan', 'Kole Francis', 'Jacquelyn Robinson', 'Glenn Frank', 'Connor Smith', 'Leroy Curry', 'Alvin Ferguson', 'Campbell Mitchell', 'Angela Buckley', 'Martha Mccarthy', 'Adalyn Mclean', 'Jamarcus Swanson', 'Elena Powers', 'Ryann Bradley', 'Chanel Blackwell', 'Rhys Yang', 'Moses Perkins', 'Hailie Barajas', 'Ryleigh Mclaughlin', 'Annabel Nielsen', 'Cale Middleton', 'Haiden Graham', 'Beatrice Meyers', 'Hunter Macdonald', 'Marvin Galloway', 'Blaine Marks', 'Miriam Kirk', 'Alexia Strickland', 'Hugo Mayo', 'Riya Hendricks', 'Lena Hobbs', 'Clarence Rangel', 'Marlie Mcgee', 'Harper Travis', 'Josh Bauer', 'Ireland Stephenson', 'Bruce Moreno', 'Konner Vaughn', 'Tanner Pearson', 'Fatima Cherry', 'Aimee Mathis', 'Miah Fisher', 'Kamren James', 'Samara Tapia', 'Amelie Rasmussen', 'Fiona Gibson', 'Deon Fletcher', 'Kingston Sexton', 'Amber Vaughan', 'Lizbeth Campos', 'Khalil Farrell', 'Peyton Ellison', 'Brodie Arellano', 'Orlando Newton', 'Vanessa Burton', 'Salvador Jensen', 'Lucy Jennings', 'Elise Hunter', 'Konnor Poole', 'Rebecca Aguirre', 'Damarion Holt', 'Iyana Pace', 'Damari Woods', 'Kaylen Vincent', 'Gavin Lewis', 'Kennedy Skinner', 'Zack Oliver', 'Simone Schaefer', 'Brice Li', 'Bryanna Cox', 'Deja Mcfarland', 'Brady Bray', 'Bradley Eaton', 'Jocelyn Larsen', 'Jovany Dawson', 'Abel Burgess', 'Kylie Moran', 'Jameson Miller', 'Natalee Best', 'Bella Wheeler', 'Romeo Bolton', 'Frank Schroeder', 'Kamari Montoya', 'Kendra Dennis', 'Naomi Whitney'
    ])
      AS name
)
INSERT INTO athletes(name, sex, height, weight, age, accomodation_id, delegation_id, volunteer_id)
  SELECT
    name,
    CASE WHEN (random() > 0.5) THEN 'male' ELSE 'female' END :: Sex,
    (140 + random() * 75) :: INT,
    (40 + random() * 60) :: INT,
    (15 + random() * 30) :: INT,
    (0.5 + random() * (SELECT COUNT(*) FROM buildings))::INT, -- todo: hostel
    (0.5 + random() * (SELECT COUNT(*) FROM delegations))::INT,
    (0.5 + random() * (SELECT COUNT(*) FROM volunteers))::INT
  FROM Names;

-- athletes_specializations
INSERT INTO athletes_specializations(athlete_id, sport_id)
  SELECT A.id, S.id
  FROM athletes A CROSS JOIN sports S
  ORDER BY random()
  LIMIT (SELECT COUNT(*) FROM athletes) * 2;

-- participations
INSERT INTO participations(competition_id, athlete_id, place)
  SELECT Com.id, athlete_id, row_number() OVER (PARTITION BY Com.id) AS place
  FROM competitions Com
  JOIN athletes_specializations ASp ON ASp.sport_id = Com.sport_id AND (random() > 0.5)
  ORDER BY random();

END;
$$ LANGUAGE plpgsql;

SELECT GenerateData();

