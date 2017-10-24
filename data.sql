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
), TT AS (
  SELECT countries.id AS id, (0.5 + random() * (SELECT COUNT(*) FROM PossibleHQ))::INT phq_id
  FROM countries
)
INSERT INTO delegations(country_id, headquarters_id)
  SELECT C.id, b_id::INT
  FROM countries C
    JOIN TT ON (TT.id = C.id)
    JOIN PossibleHQ P ON (P.id = phq_id);

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
    FROM unnest(ARRAY['Ginger Flores', 'Tasha Holt', 'Angel Mclaughlin', 'Erin Lee', 'Lindsay Long', 'Sherri Simon', 'Milton Cruz', 'Eleanor Rivera', 'Don Moody', 'Howard Craig', 'Julius Torres', 'Jackie Black', 'Steven Holland', 'Kristopher Munoz', 'Roland Fitzgerald', 'Jay Fields', 'Joan Butler', 'Marcos Hamilton', 'Teri Miller', 'Victoria Daniel', 'Lance Tate', 'Ann Clayton', 'Mark Bryant', 'Gloria Andrews', 'Clifford Marsh', 'Tomas Reese', 'Kenneth Townsend', 'Amy Benson', 'Patsy Vaughn', 'Isabel Waters', 'Tiffany Walker', 'Merle Rice', 'Lisa Yates', 'Rudolph Carroll', 'Christian Watkins', 'Elizabeth West', 'Essie Mills', 'Dwayne Boone', 'Pam Wheeler', 'Diana Dawson', 'Leslie Jenkins', 'Rudy Edwards', 'Ismael Reynolds', 'Darrell Tucker', 'Cynthia Swanson', 'Regina Logan', 'Yvonne Bridges', 'Stephanie Lawrence', 'Cathy Castro', 'Nicholas Harrison', 'Elsa Rodgers', 'Wade Alexander', 'Leticia Berry', 'Jim Cain', 'Vivian Holmes', 'Marie Mann', 'Drew Knight', 'Chester Green', 'Kenny Hanson', 'Cory May', 'Corey Peters', 'Erica Diaz', 'Norma Baldwin', 'Blake Stevens', 'Ramiro Woods', 'Lorenzo Gutierrez', 'Kimberly Spencer', 'Johnnie Ford', 'Willard Barnett', 'Vickie Wilkerson', 'Pat Cortez', 'Jodi Lynch', 'Angie Rios', 'Pauline Oliver', 'Theodore Robinson', 'Dana Hicks', 'Lee Aguilar', 'Todd Bishop', 'Myrtle Mathis', 'Susan Bryan', 'Lawrence Cohen', 'Edna Freeman', 'William Young', 'Cecelia Sutton', 'Calvin Brady', 'Holly Bass', 'Kathleen Newton', 'Randy Jefferson', 'Faith Marshall', 'Jackie Elliott', 'Fred Santos', 'Christina Park', 'Angel Jones', 'Tyrone Morgan', 'Cary Barnes', 'Pete Barker', 'Sylvia Richards', 'Austin Rose', 'Emmett Nunez', 'Bruce Weaver', 'Kenny Ballard', 'Benny Soto', 'Javier Myers', 'Mindy Phelps', 'Robert Mcdonald', 'Sabrina Hughes', 'Ignacio Williamson', 'Stanley Todd', 'Nick Kim', 'Joe Joseph', 'Monica Brewer', 'Russell Larson', 'Conrad Holt', 'Jason Castro', 'Shelia Barton', 'Edwin Haynes', 'Verna Sherman', 'Gloria Copeland', 'Seth Farmer', 'Ian Alvarez', 'Colin Ramos', 'Bradley Fisher', 'Bryan Owens', 'Kirk Black', 'Mona Mcguire', 'Daryl Long', 'Sandy Simpson', 'Alejandro Curry', 'Keith Bennett', 'Travis Burke', 'Genevieve Hamilton', 'Opal Wolfe', 'Felipe Hanson', 'Louise Strickland', 'Maureen Wilson', 'Patrick Becker', 'Betsy Roberts', 'Suzanne Mccoy', 'Faith Garrett', 'Garrett Christensen', 'Dean Cobb', 'Homer Fields', 'Adam Rodgers', 'Vicki Gonzalez', 'Gary Hansen', 'Adrienne Jones', 'Preston Baldwin', 'Lillie Cummings', 'Joanna Stevenson', 'Darryl Valdez', 'Viola Burton', 'Rudolph Goodwin', 'Bobbie Weber', 'Elijah Wallace', 'Crystal Kelley', 'Garry Kennedy', 'Jacob Ramsey', 'Terence Bridges', 'Darren Riley', 'Marcos Watts', 'Becky Maldonado', 'Erma Berry', 'Dennis Rose', 'Elizabeth Dunn', 'Hope Stephens', 'Marvin Phillips', 'Edgar Rhodes', 'Angel Vaughn', 'Andy Martinez', 'Francis Fowler', 'Ray Brooks', 'Bob Ryan', 'Randal Hampton', 'Derrick Barnett', 'Laura Moreno', 'Anne Price', 'Ernesto Massey', 'Shannon Roberson', 'Kay Garner', 'Devin Franklin', 'Jacqueline Lee', 'Kevin Evans', 'Gregg Jackson', 'Rachel Guerrero', 'Calvin Day', 'Tomas Marshall', 'Sonja Schmidt', 'Christina Butler', 'Casey Reeves', 'Terrence Lowe', 'Johnnie Martin', 'Jeanette Brady', 'Noel Doyle', 'Tabitha Allen', 'Kent Welch', 'Debbie Daniel', 'Agnes Cannon', 'Violet Moore', 'Rolando Padilla', 'Belinda Greer', 'Angelo Cole', 'Lowell Rose', 'Jerry Garner', 'Justin Bridges', 'Mabel Cobb', 'Lance Becker', 'Dustin Pope', 'Holly French', 'Maryann Riley', 'Leon Wilkins', 'Joanna Reeves', 'Tom Walters', 'Dorothy Barnett', 'Lewis Carson', 'Kellie Greer', 'Corey Long', 'Johnnie Barber', 'Shannon Fields', 'Lee Chapman', 'Lana Barrett', 'Catherine White', 'Nathan Lane', 'Damon Farmer', 'Blanca Tate', 'Clayton Vega', 'Peter Rowe', 'Bertha Newton', 'Francis Owen', 'Lawrence Ingram', 'Rosalie Pearson', 'Joshua Hayes', 'Leah Higgins', 'Joe Young', 'Lula Reese', 'Jody Flores', 'Ivan King', 'Isabel Walsh', 'Georgia Sandoval', 'Brendan Miles', 'Marilyn Bailey', 'Antonia Horton', 'Jerald Stanley', 'Eva Stevenson', 'Jennifer Schmidt', 'Kristopher Briggs', 'Guillermo Mann', 'Dean Ortega', 'Marjorie Montgomery', 'Hattie Castro', 'Crystal Hudson', 'Gregory Thompson', 'Vicki Bell', 'Alton Goodwin', 'Adam Allison', 'Estelle Mcgee', 'Lindsey Lyons', 'Pauline Moran', 'Janie Burns', 'Chester Norton', 'Monica Schneider', 'Rafael Hawkins', 'Frank Joseph', 'Della Ballard', 'Glenda Washington', 'Vernon Carpenter', 'Carroll West', 'Constance Harrison', 'Bethany Carr', 'Wilbur Price', 'Doreen Medina', 'Gertrude Harrington', 'Gilberto Fox', 'Kristy Rios', 'Aubrey Barton', 'Jeannie Mendez', 'Harry Lawson', 'Deborah Salazar', 'Lucia Houston', 'Eloise Harris', 'Bobbie Summers', 'Antonio Herrera', 'Beth Moreno', 'Sherri Terry', 'Kurt Roberson', 'Monique Daniels', 'Dominic Logan', 'Claire Pratt', 'Claude Richards', 'Raul Graham', 'Leslie Kennedy', 'Ted Jennings', 'Roger Myers', 'Roosevelt Soto', 'Lila Padilla', 'Andres Gibbs', 'Doug Pittman', 'Andy Cummings', 'Jeannette Perry', 'Ella George', 'Stuart Fleming', 'Robyn Montgomery', 'Priscilla Hudson', 'Ginger Washington', 'Johnnie Wilson', 'Lloyd Reynolds', 'Tabitha Wise', 'Alfredo Wilkins', 'Cora Flowers', 'Lillian Silva', 'Terri Brooks', 'Harold Riley', 'Bertha Murphy', 'Juanita Thomas', 'Wendy Osborne', 'Bert Brock', 'Theodore Massey', 'Mathew Soto', 'Jana Young', 'Lola Conner', 'Gertrude Boone', 'Israel Mendez', 'Melba Sherman', 'Rochelle Fisher', 'Max Delgado', 'Sandra Hodges', 'Robin Jefferson', 'Joanna Morris', 'Ricky Alvarez', 'Patrick Mccoy', 'Elvira Banks', 'Mable Andrews', 'Krystal Vargas', 'Salvador Ramsey', 'Kelvin Lambert', 'Benjamin Santiago', 'Evan Cunningham', 'Jacqueline Medina', 'Stephanie Guerrero', 'Ernestine Carpenter', 'Gina Mcguire', 'Pedro Aguilar', 'Rosa Sharp', 'Christy Bridges', 'Laurence Smith', 'Marco Pittman', 'Florence Stevenson', 'Dorothy Mann', 'Amos Moreno', 'Ann Patton', 'Alberta Poole', 'Kent Stephens', 'Lawrence Pratt', 'Tara Alvarado', 'Cornelius Miles', 'Lucy Ferguson', 'Angelo Porter', 'Ora Parks', 'Kelley Warner', 'Marianne Hughes', 'Armando Clarke', 'Cathy Bowen', 'Courtney Obrien', 'Kerry Peters', 'Philip Benson', 'Nadine Zimmerman', 'Kenneth Harper', 'Earnest Potter', 'Yvette Coleman', 'Lonnie Jenkins', 'Conrad King', 'Bennie Hubbard', 'Stewart Copeland', 'Annie Garza', 'Geraldine Matthews', 'Mack Powell', 'Georgia Dennis', 'Nicolas Perez', 'Otis Caldwell', 'Merle Ball', 'Herman Yates', 'Raymond Jennings', 'Blanche Ross', 'Elmer Todd', 'Freddie Cooper', 'Kristin Moore', 'Erika Roberts', 'Thelma Reeves', 'Travis Steele', 'Vicky Bowers', 'Alexis Nash', 'Victoria Watkins', 'Carlton Norman', 'Ross Goodman', 'Yvonne Mack', 'Scott Griffin', 'Elena Sanchez', 'Tyrone Houston', 'Terry Burgess', 'Dwayne Harrison', 'Austin Francis', 'Bobbie Vega', 'Ernestine Lawrence', 'Garry Larson', 'Meghan Lindsey', 'Melissa Montgomery', 'Julio Keller', 'Randy Graves', 'Lela Oliver', 'Jeanette Mack', 'Jamie Griffith', 'Deborah Gibbs', 'Jim Weber', 'Jerald Chapman', 'Carole Brown', 'Diane Bowers', 'Pablo Reynolds', 'Olive Hicks', 'Angela Cain', 'Joanne Hogan', 'Hugh Kim', 'Jody Conner', 'Yvette Welch', 'Vera Silva', 'Myron Ward', 'Shane Robertson', 'Cynthia Price', 'Antoinette Mullins', 'Shelia Moore', 'Irvin Miles', 'Alexis Grant', 'Monique Bennett', 'Forrest Johnson', 'Tonya Goodman', 'Olga Riley', 'Ethel Hanson', 'Anne Austin', 'Mercedes Sanders', 'Alan Baldwin', 'Kendra Simmons', 'Steven Blair', 'Lucas Guzman', 'Harriet Morris', 'Darryl Luna', 'Myra Lawson', 'Robin Harper', 'Guadalupe Mason', 'Christine Sullivan', 'Kelli Wells', 'Casey Hart', 'Fernando Shaw', 'Kyle Brady', 'Mathew Bowen', 'Tamara Lopez', 'Doreen Stephens', 'Alexandra Neal', 'Lorraine Carr', 'Wayne Lowe', 'Virgil Greene', 'Sean Phillips', 'Pat Rios', 'Gretchen Watkins', 'Edmund Hunter', 'Edwin Wilson', 'Paula Green', 'Guadalupe Pearson', 'Everett Doyle', 'Miriam Brewer', 'Anita Duncan', 'Carlton Todd', 'Glenda Dixon', 'Nicholas Hamilton', 'Lola Maldonado', 'Beth Wood', 'Toni Glover', 'Marsha Castillo', 'Sherry Bates', 'Darrin Hunt', 'Cindy Hubbard', 'Edna Mckinney', 'Wanda Simon', 'Lindsey Burgess', 'Gene Harris', 'Brad Rose', 'Anthony Sherman', 'Mario Mccoy', 'Sonia Nash', 'David Pittman', 'Warren Howard', 'Rodney Roberson', 'Heather Bush', 'Velma Patton', 'Clayton Pierce', 'Bridget Gordon', 'Denise Martinez', 'Krista Willis', 'Ivan Sandoval', 'Allan Harrington', 'Arnold Joseph', 'Antonio Hodges', 'Marion Hopkins', 'Louis Mccormick', 'Saul Smith', 'Latoya Carlson', 'Mitchell Newton', 'Kim Cole', 'Valerie Hayes', 'Bennie Bridges', 'Alexis Lucas', 'Lynda Banks', 'Gabriel Wade', 'Martin Brooks', 'Rachael Clarke', 'Shelley Frazier', 'Doris Grant', 'Arnold Murray', 'Catherine Poole', 'Terry Hopkins', 'Meredith Hernandez', 'Shawna Francis', 'Carole Cruz', 'Maryann Holland', 'Guillermo George', 'Leo Romero', 'Carlton Gordon', 'Pete Morales', 'Kevin Phelps', 'Ann Morgan', 'Constance Butler', 'Fernando Munoz', 'Martha Gilbert', 'Amy West', 'Hubert Ingram', 'Velma Jimenez', 'Jon Stevens', 'Beulah Caldwell', 'Minnie Colon', 'Antonio Park', 'Shawn Newman', 'Jeffrey Mccoy', 'Candice Love', 'Toni Wood', 'Alberto Meyer', 'Margaret Harris', 'Woodrow Bennett', 'Ivan Goodman', 'Hilda Hammond', 'Terrence Willis', 'Joann Mendez', 'Anna Chandler', 'Henrietta Lyons', 'Ramiro Holmes', 'Rex Moreno', 'Jamie Ray', 'Colin Washington', 'Luther Guzman', 'Melinda Wheeler', 'Max Hogan', 'Timmy Soto', 'Diana Edwards', 'Meghan Hansen', 'Lance Barnes', 'Julius Wilkins', 'Brad Norman', 'Jerome Flores', 'Jo Pope', 'Deborah Martin', 'Marcella Mccarthy', 'Celia Taylor', 'Fredrick Elliott', 'Levi Todd', 'Rosalie Sherman', 'Rosie Cortez', 'Kathryn Norton', 'Gilbert Davidson', 'Hugo Cook', 'Marguerite Owen', 'Bonnie Roberson', 'Darla Mckinney', 'Lionel Griffith', 'Jimmy Campbell', 'Judy Delgado', 'Robert Wright', 'Kristi Holt', 'Alex Martinez', 'Essie Craig', 'Herman Garner', 'Johnny Day', 'Mae Watkins', 'Molly Valdez', 'Gerardo Hunter', 'Jermaine Bush', 'Iris Reyes', 'Lori Haynes', 'Bertha Curry', 'Josephine Cain', 'Charlene Jordan', 'Moses Baldwin', 'Pauline Estrada', 'Ellen Lewis', 'Micheal Henry', 'Kristi Todd', 'Jerome Keller', 'Conrad Norton', 'Tonya Rodriguez', 'Opal Mills', 'Maxine Perry', 'Bob Fuller', 'Theresa Banks', 'Scott Powell', 'Wilma Hanson', 'Olivia Williamson', 'Dana Manning', 'Samantha Owens', 'Casey Lambert', 'Antonia Reese', 'Miranda Mason', 'Alberto Stevens', 'Preston Harris', 'Danielle Morgan', 'Rogelio Vasquez', 'Lula Bailey', 'Donna Wells', 'Ramon Nguyen', 'Gregg Carpenter', 'Whitney Blake', 'Krystal Buchanan', 'Clint Norris', 'Horace Padilla', 'Luis Potter', 'Andres Morrison', 'Loretta Aguilar', 'Diane Mendez', 'Lynn Carr', 'Steven Brock', 'Toby Kelly', 'Rudolph Ray', 'Tyler Waters', 'Wm Long', 'Bobby Walker', 'Colin Anderson', 'Ed Daniels', 'Marion Perkins', 'Mandy Bowers', 'Felipe Mullins', 'Gary Christensen', 'Nathaniel Singleton', 'Delia Ramsey', 'Thomas Allen', 'Grace Mcbride', 'Vernon Carter', 'Kimberly Adkins', 'Jose Armstrong', 'William Mcdonald', 'Ernestine Schmidt', 'Marjorie Love', 'Tom May', 'Clarence Ingram', 'Ramiro Ortega', 'Joy Mathis', 'Angelina Wilkins', 'Luke Poole', 'Isabel Bell', 'Alejandro Joseph', 'Cristina Francis', 'Stella Bowman', 'Bradley Campbell', 'Derrick Robbins', 'Robin Floyd', 'Glenda Walsh', 'Hannah Bates', 'Kenny Fleming', 'Mona Hunter', 'Rosalie Mccarthy', 'Sylvester Shelton', 'Ida Reed', 'Karl Soto', 'Willis Lynch', 'Wayne Gibbs', 'Shaun Barrett', 'Ben Hernandez', 'Tyrone Gilbert', 'Nina Howell', 'Adam Swanson', 'Kay Freeman', 'Isaac Parker', 'Bradford Mann', 'Marco Wilson', 'Everett Huff', 'Renee Flores', 'Ted Ramirez', 'Earnest Strickland', 'Maureen Little', 'Andre Drake', 'Lorenzo Pearson', 'Tracey George', 'Shane Burke', 'Jeffery Norman', 'Dallas Copeland', 'Rafael Wright', 'Gayle Bennett'
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

