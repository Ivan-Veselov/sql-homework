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
    SELECT name, row_number() OVER () as id
    FROM
      unnest(ARRAY['Tibedied', 'Qube', 'Leleer', 'Biarge', 'Xequerin', 'Tiraor', 'Rabedira', 'Lave', 'Zaatxe', 'Diusreza', 'Teaatis', 'Riinus', 'Esbiza', 'Ontimaxe', 'Cebetela', 'Ceedra', 'Rizala', 'Atriso', 'Teanrebi', 'Azaqu', 'Retila', 'Sotiqu', 'Inleus', 'Onrira', 'Ceinzala', 'Biisza', 'Legees', 'Quator', 'Arexe', 'Atrabiin', 'Usanat', 'Xeesle', 'Oreseren', 'Inera', 'Inus', 'Isence', 'Reesdice', 'Terea', 'Orgetibe', 'Reorte', 'Ququor', 'Geinona', 'Anarlaqu', 'Oresri', 'Esesla', 'Socelage', 'Riedquat', 'Gerege', 'Usle', 'Malama', 'Aesbion', 'Alaza', 'Xeaqu', 'Raoror', 'Ororqu', 'Leesti', 'Geisgeza', 'Zainlabi', 'Uscela', 'Isveve', 'Tioranin', 'Learorce', 'Esusti', 'Ususor', 'Maregeis', 'Aate', 'Sori', 'Cemave', 'Arusqudi', 'Eredve', 'Regeatge', 'Edinso', 'Ra', 'Aronar', 'Arraesso', 'Cevege', 'Orteve', 'Geerra', 'Soinuste', 'Erlage', 'Xeaan', 'Veis', 'Ensoreus', 'Riveis', 'Bivea', 'Ermaso', 'Velete', 'Engema', 'Atrienxe', 'Beusrior', 'Ontiat', 'Atarza', 'Arazaes', 'Xeeranre', 'Quzadi', 'Isti', 'Digebiti', 'Leoned', 'Enzaer', 'Teraed', 'Vetitice', 'Laenin', 'Beraanxe', 'Atage', 'Veisti', 'Zaerla', 'Esredice', 'Beor', 'Orso', 'Usatqura', 'Erbiti', 'Reinen', 'Ininbi', 'Erlaza', 'Celabile', 'Ribiso', 'Qudira', 'Isdibi', 'Gequre', 'Rarere', 'Aerater', 'Atbevete', 'Bioris', 'Raale', 'Tionisla', 'Encereso', 'Anerbe', 'Gelaed', 'Onusorle', 'Zaonce', 'Diquer', 'Zadies', 'Entizadi', 'Esanbe', 'Usralaat', 'Anlere', 'Teveri', 'Sotiera', 'Ededleen', 'Inonri', 'Esbeus', 'Lerelace', 'Eszaraxe', 'Anbeen', 'Biorle', 'Anisor', 'Usrarema', 'Diso', 'Riraes', 'Orrira', 'Xeer', 'Ceesxe', 'Isatre', 'Aona', 'Isinor', 'Uszaa', 'Aanbiat', 'Bemaera', 'Inines', 'Edzaon', 'Leritean', 'Veale', 'Edle', 'Anlama', 'Ribilebi', 'Relaes', 'Dizaoner', 'Razaar', 'Enonla', 'Isanlequ', 'Tibecea', 'Sotera', 'Esveor', 'Esteonbi', 'Xeesenri', 'Oresle', 'Ervein', 'Larais', 'Anxebiza', 'Diedar', 'Eninre', 'Bibe', 'Diquxe', 'Sorace', 'Anxeonis', 'Riantiat', 'Zarece', 'Maesin', 'Tibionis', 'Gelegeus', 'Diora', 'Rigeti', 'Begeabi', 'Orrere', 'Beti', 'Gerete', 'Qucerere', 'Xeoner', 'Xezaor', 'Ritila', 'Edorte', 'Zaalela', 'Biisorte', 'Beesor', 'Oresqu', 'Xeququti', 'Maises', 'Bierle', 'Arzaso', 'Teen', 'Riredi', 'Teorge', 'Vebege', 'Xeenle', 'Arxeza', 'Edreor', 'Esgerean', 'Ditiza', 'Anle', 'Onisqu', 'Aleusqu', 'Zasoceat', 'Rilace', 'Beenri', 'Laeden', 'Mariar', 'Riiser', 'Qutiri', 'Biramabi', 'Soorbi', 'Solageon', 'Tiquat', 'Rexebe', 'Qubeen', 'Cetiisqu', 'Rebia', 'Ordima', 'Aruszati', 'Zaleriza', 'Zasoer', 'Raleen', 'Qurave', 'Atrebibi', 'Teesdi', 'Ararus', 'Ara', 'Tianve', 'Quorte', 'Soladies', 'Maxeedso', 'Xexedi', 'Xexeti', 'Tiinlebi', 'Rateedar', 'Onlema', 'Orerve'])
        AS name
)
INSERT INTO buildings(street, house_number, name, type_id)
    SELECT street, number, name,  (0.5 + random() * (SELECT COUNT(*) FROM building_types))::int
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
  LIMIT (SELECT COUNT(*) FROM building_specializations) * 2;

-- delegations
WITH PossibleHQ AS (
  SELECT B.id as b_id, row_number() OVER () as id
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
  SELECT name, row_number() OVER () as id
  FROM unnest(ARRAY['Громозека', 'Ким', 'Буран', 'Зелёный', 'Горбовский', 'Ийон Тихий', 'Форд Префект', 'Комов', 'Каммерер', 'Ким', 'Гагарин', 'Армстронг', 'Гленн', 'Леонов'])
    AS name
), Phones AS (
  SELECT phone, row_number() OVER () as id
  FROM unnest(ARRAY['(379) 662-9283', '(707) 978-6090', '(494) 379-9610', '(326) 387-9599', '(901) 990-4462', '(660) 674-0306', '(839) 305-6616', '(664) 303-1204', '(452) 157-0050', '(461) 282-9723', '(590) 792-2320', '(857) 454-3422', '(824) 787-2640', '(488) 665-9441', '(874) 767-7121', '(254) 673-7048', '(411) 669-1384', '(787) 940-8061', '(510) 760-5791', '(755) 812-5537'])
    AS phone
)
INSERT INTO delegation_leaders(name, telephone_number, delegation_id)
  SELECT name, phone, (0.5 + random() * (SELECT COUNT(*) FROM Delegations))::int
  FROM Names N JOIN Phones P ON N.id = P.id;


END;
$$ LANGUAGE plpgsql;

SELECT GenerateData();

