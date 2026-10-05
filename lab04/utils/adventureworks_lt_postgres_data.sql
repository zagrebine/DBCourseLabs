
BEGIN;

-- ---------- Категории ----------
INSERT INTO production.productcategory (name) VALUES
 ('Accessories'), ('Bikes'), ('Clothing'), ('Components');

-- ---------- Модели ----------
INSERT INTO production.productmodel (name, catalogdescription) VALUES
 ('HL Mountain Frame',      'Алюминиевая рама для горных велосипедов.'),
 ('LL Road Frame',          'Стальная рама для шоссейных велосипедов.'),
 ('Sport-100 Helmet',       'Классический шлем начального уровня.'),
 ('Mountain Bike Socks',    'Термоноски для катания в холодную погоду.'),
 ('Racing Socks',           'Легкие гоночные носки.'),
 ('Chain',                  'Усиленная цепь для горных велосипедов.'),
 ('Bearing Ball',           'Шарикоподшипник стандартного размера.'),
 ('Classic Vest',           'Светоотражающий жилет для велоспорта.'),
 ('Cable Lock',             'Стальной тросовый замок с ключом.'),
 ('Water Bottle',           'Поликарбонатная бутылка 0,7 л.');

-- ---------- Товары ----------
INSERT INTO production.product (name, productnumber, color, standardcost, listprice, sellstartdate, sellenddate, productcategoryid, productmodelid) VALUES
 ('Sport-100 Helmet, Red',    'HL-U509-R', 'Red',    7.1429,  34.99,  DATE '2005-07-01', DATE '2012-05-29', 1, 3),
 ('Sport-100 Helmet, Blue',   'HL-U509-B', 'Blue',   7.1429,  34.99,  DATE '2005-07-01', DATE '2012-05-29', 1, 3),
 ('Sport-100 Helmet, Black',  'HL-U509',   'Black',  7.1429,  34.99,  DATE '2005-07-01', DATE '2012-05-29', 1, 3),
 ('Road Bike Frame - Black',  'FR-R92B-58','Black', 1364.4952, 1700.99, DATE '2005-06-01', DATE '2012-05-29', 2, 2),
 ('Road Bike Frame - Red',    'FR-R92R-58','Red',   1364.4952, 1700.99, DATE '2005-06-01', DATE '2012-05-29', 2, 2),
 ('Mountain Bike Frame - Silver','FR-M94S-38','Silver', 1084.3861, 1364.50, DATE '2005-06-01', DATE '2012-05-29', 2, 1),
 ('Mountain Bike Frame - Green','FR-M94G-42','Green',1084.3861, 1364.50, DATE '2005-06-01', DATE '2012-05-29', 2, 1),
 ('Chain Stays',              'CS-2818',   NULL,     4.3964,  12.00,  DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('Headset Ball Bearings',    'HB-M244',   NULL,    20.4167,  35.00,  DATE '2005-06-01', DATE '2012-05-29', 4, 7),
 ('LL Mountain Handlebars',   'HB-M63-R',  'Red',    21.0748,  44.54, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('HL Mountain Handlebars',   'HB-M76-S',  'Silver', 21.0748,  44.54, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('LL Mountain Front Wheel',  'FW-M76-24', NULL,    108.4714, 145.75, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('HL Mountain Front Wheel',  'FW-M76-29', NULL,    136.2031, 175.49, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('LL Road Front Wheel',      'FW-R58-30', NULL,     74.2352, 100.00, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('HL Road Front Wheel',      'FW-R58-38', NULL,     96.3965, 130.00, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('ML Mountain Tire',         'TI-M75-M',  NULL,     14.1397,  24.99, DATE '2005-06-01', DATE '2012-05-29', 1, NULL),
 ('HL Road Tire',             'TI-H80-R',  NULL,     19.7177,  32.60, DATE '2005-06-01', DATE '2012-05-29', 1, NULL),
 ('Touring Tire',             'TI-T89-T',  NULL,     19.7177,  32.60, DATE '2005-06-01', DATE '2012-05-29', 1, NULL),
 ('Mountain Bike Socks, M',   'SO-B909-M', 'White',   3.3963,   9.50, DATE '2005-06-01', DATE '2012-05-29', 3, 4),
 ('Mountain Bike Socks, L',   'SO-B909-L', 'White',   3.3963,   9.50, DATE '2005-06-01', DATE '2012-05-29', 3, 4),
 ('Racing Socks, M',          'SO-C109-M', 'White',   3.3963,   8.50, DATE '2005-06-01', DATE '2012-05-29', 3, 5),
 ('Classic Vest, S',          'VE-C304-S', 'Blue',   11.5226,  26.33, DATE '2005-06-01', DATE '2012-05-29', 3, 8),
 ('Classic Vest, L',          'VE-C304-L', 'Blue',   11.5226,  26.33, DATE '2005-06-01', DATE '2012-05-29', 3, 8),
 ('Cable Lock',               'LO-C100',   NULL,     14.9435,  25.00, DATE '2005-06-01', DATE '2012-05-29', 1, 9),
 ('Water Bottle - 30 oz.',    'WB-H097',   'Blue',    1.8662,   4.99, DATE '2005-06-01', DATE '2012-05-29', 1, 10),
 ('Water Bottle - 24 oz.',    'WB-H098',   'White',   1.8662,   4.99, DATE '2005-06-01', DATE '2012-05-29', 1, 10),
 ('LL Road Pedal',            'PD-R347',   NULL,      7.2663,  15.00, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('ML Road Pedal',            'PD-M340',   NULL,     24.9219,  40.00, DATE '2005-06-01', DATE '2012-05-29', 4, 6),
 ('Patch Kit',                'PK-7098',   NULL,      1.2493,   2.99, DATE '2005-06-01', DATE '2012-05-29', 1, NULL),
 ('Mini Pump',                'MP-2030',   NULL,      4.2044,   9.99, DATE '2005-06-01', DATE '2012-05-29', 1, NULL);

-- ---------- Клиенты (компании и частные лица) ----------
INSERT INTO sales.customer (namestyle, firstname, lastname, companyname, emailaddress, phone) VALUES
 (false, 'Orlando',  'Gee',        'A Bike Store',            'orlando0@adventure-works.example',  '245-555-0173'),
 (false, 'Keith',    'Harris',     'Progressive Sports',      'keith0@adventure-works.example',    '170-555-0127'),
 (false, 'Donna',    'Carreras',   'Advanced Bike Components','donna0@adventure-works.example',    '279-555-0110'),
 (false, 'Janet',    'Gates',      'Metropolitan Sports Supply','janet1@adventure-works.example',  '710-555-0173'),
 (true,  'Lucia',    'Benelito',   'Compete Enterprises, Inc','lucia2@adventure-works.example',    '877-332-4112'),
 (true,  'Lisa',     'Miller',     'Aerobic Exercise Company','lisa3@adventure-works.example',     '310-555-0199'),
 (false, 'Mark',     'Harrington', 'Bulk Discount Store',     'mark4@adventure-works.example',     '320-555-0181'),
 (false, 'Tina',     'Mackenzie',  'Enterprise Industries',   'tina5@adventure-works.example',     '457-555-0100'),
 (false, 'Ryan',     'LaRocca',    'Futuristic Bikes',        'ryan6@adventure-works.example',     '507-555-0143'),
 (false, 'Richard',  'Bready',     'Gardens & Co.',           'richard7@adventure-works.example',  '587-555-0167'),
 (false, 'Alicia',   'Thomasson',  'Hand Tools & Supplies',   'alicia8@adventure-works.example',   '610-555-0135'),
 (false, 'Venus',    'Brown',      'Hill Bicycle Center',     'venus9@adventure-works.example',    '620-555-0154'),
 (false, 'Darren',   'Kennedy',    'Industries International','darren10@adventure-works.example',  '670-555-0112'),
 (false, 'Frances',  'Zhou',       'Intelligent Assist',      'frances11@adventure-works.example', '670-555-0197'),
 (false, 'Spencer',  'Kamphuis',   'Journey Gear Store',      'spencer12@adventure-works.example', '707-555-0128'),
 (false, 'Michelle', 'Marshall',   'Kwik-Kost, Inc.',         'michelle13@adventure-works.example','707-555-0174'),
 (false, 'Robert',   'Sandoval',   'Lone Star Supply',        'robert14@adventure-works.example',  '707-555-0142'),
 (false, 'Brenda',   'Munoz',      'Metcalf Market',          'brenda15@adventure-works.example',  '707-555-0152'),
 (false, 'Gary',     'Girard',     'Nationwide Supply',       'gary16@adventure-works.example',    '707-555-0196'),
 (false, 'Natalie',  'Garcia',     'Next-Gen Hardware',       'natalie17@adventure-works.example', '707-555-0109'),
 (false, 'Peter',    'Kuhs',       'Online Bike Depot',       'peter18@adventure-works.example',   '707-555-0119'),
 (false, 'Pamela',   'O''Rourke',  'Pro Sport Equipment',     'pamela19@adventure-works.example',  '707-555-0136'),
 (false, 'David',    'Chen',       'Quality Sports',          'david20@adventure-works.example',   '707-555-0111'),
 (false, 'Karen',    'Fernandez',  'Retail Dynamics',         'karen21@adventure-works.example',   '707-555-0131'),
 (false, 'Jose',     'Rivera',     'Ride & Race Shop',        'jose22@adventure-works.example',    '707-555-0185'),
 (false, 'Sara',     'Miller',     'Southside Cycles',        'sara23@adventure-works.example',    '707-555-0147'),
 (false, 'Thomas',   'Wright',     'Speedway Sports',         'thomas24@adventure-works.example',  '707-555-0125'),
 (false, 'Anna',     'Ivanova',    'Tri-State Bikes',         'anna25@adventure-works.example',    '707-555-0160'),
 (false, 'Igor',     'Petrov',     'Urban Riders',            'igor26@adventure-works.example',    '707-555-0149'),
 (false, 'Elena',    'Smirnova',   'Valley Sports',           'elena27@adventure-works.example',   '707-555-0177'),
 (false, 'Maxim',    'Orlov',      'Westside Wheels',         'maxim28@adventure-works.example',   '707-555-0191'),
 (false, 'Olga',     'Kuznetsova', 'Worldwide Bikes',         'olga29@adventure-works.example',    '707-555-0158');

-- ---------- Адреса ----------
INSERT INTO sales.address (addressline1, addressline2, city, stateprovince, countryregion, postalcode) VALUES
 ('1010 Park Ave',      NULL,            'New York',       'New York',      'United States', '10001'),
 ('2357 Westwood Blvd', NULL,            'Los Angeles',    'California',    'United States', '90064'),
 ('1200 Industrial Pkwy','Building 2',   'Chicago',        'Illinois',      'United States', '60607'),
 ('88 Bay Shore Rd',    NULL,            'Miami',          'Florida',       'United States', '33101'),
 ('456 Cedar St',       'Suite 12',      'Seattle',        'Washington',    'United States', '98101'),
 ('2200 Main St',       NULL,            'Dallas',         'Texas',         'United States', '75201'),
 ('77 Baker Street',    NULL,            'London',         'Greater London','United Kingdom','W1U 8ED'),
 ('10 Tverskaya St',    NULL,            'Moscow',         'Moscow',        'Russia',        '125009'),
 ('22 Nevsky Ave',      'Office 401',    'Saint Petersburg','Saint Petersburg','Russia',     '190000'),
 ('300 Fifth Ave',      NULL,            'New York',       'New York',      'United States', '10018'),
 ('510 Elm Rd',         NULL,            'Austin',         'Texas',         'United States', '73301'),
 ('900 Harbor Blvd',    NULL,            'San Diego',      'California',    'United States', '92101'),
 ('15 Rue de Rivoli',   NULL,            'Paris',          'Ile-de-France', 'France',        '75004'),
 ('60 Marienstrasse',   NULL,            'Berlin',         'Berlin',        'Germany',       '10117'),
 ('1800 Elm St',        NULL,            'Denver',         'Colorado',      'United States', '80202');

-- ---------- Связь клиент-адрес ----------
INSERT INTO sales.customeraddress (customerid, addressid, addresstype) VALUES
 (1, 1, 'Main Office'), (1, 3, 'Shipping'),
 (2, 2, 'Main Office'), (2, 2, 'Shipping'),
 (3, 3, 'Main Office'),
 (4, 4, 'Main Office'), (4, 5, 'Shipping'),
 (5, 5, 'Main Office'),
 (6, 6, 'Main Office'), (6, 6, 'Shipping'),
 (7, 7, 'Main Office'), (7, 12, 'Shipping'),
 (8, 8, 'Main Office'),
 (9, 9, 'Main Office'), (9, 10, 'Shipping'),
 (10, 10, 'Main Office'),
 (11, 11, 'Main Office'), (11, 11, 'Shipping'),
 (12, 12, 'Main Office'),
 (13, 13, 'Main Office'), (13, 4, 'Shipping'),
 (14, 14, 'Main Office'),
 (15, 1, 'Main Office'), (15, 1, 'Shipping'),
 (16, 2, 'Main Office'),
 (17, 3, 'Main Office'), (17, 3, 'Shipping'),
 (18, 4, 'Main Office'),
 (19, 5, 'Main Office'), (19, 5, 'Shipping'),
 (20, 6, 'Main Office');

-- Клиенты 21-32 не имеют адресов

-- ---------- Заказы ----------
INSERT INTO sales.salesorderheader (orderdate, duedate, status, customerid, subtotal, taxamt, freight, totaldue, comment) VALUES
 ('2025-01-15', '2025-01-22', 5, 1,  1183.46,  94.68,  29.59, 1307.73, 'Крупный заказ, доставка курьером.'),
 ('2025-02-03', '2025-02-10', 5, 4,  2712.65, 216.99,  67.80, 2997.44, NULL),
 ('2025-02-17', '2025-02-24', 5, 7,   350.48,  28.04,   8.76,  387.28, 'Срочная доставка.'),
 ('2025-03-05', '2025-03-12', 5, 2,   515.28,  41.22,  12.88,  569.38, NULL),
 ('2025-03-21', '2025-03-28', 5, 9,  1770.99, 141.68,  44.27, 1956.94, NULL),
 ('2025-04-02', '2025-04-09', 5, 11,  265.31,  21.22,   6.63,  293.16, NULL),
 ('2025-04-18', '2025-04-25', 5, 6,  3482.19, 278.58,  87.05, 3847.82, 'Оплачен полностью.'),
 ('2025-05-06', '2025-05-13', 5, 13,  425.70,  34.06,   8.51,  468.27, NULL),
 ('2025-05-20', '2025-05-27', 5, 15,  961.84,  76.95,  24.05, 1062.84, NULL),
 ('2025-06-03', '2025-06-10', 5, 17,  217.47,  17.40,   5.44,  240.31, NULL),
 ('2025-06-24', '2025-07-01', 5, 19, 1529.90, 122.39,  38.25, 1690.54, 'Повторный клиент.'),
 ('2025-07-08', '2025-07-15', 5, 10,  483.60,  38.69,  12.09,  534.38, NULL),
 ('2025-07-22', '2025-07-29', 5, 20,  695.95,  55.68,  17.40,  769.03, NULL),
 ('2025-08-05', '2025-08-12', 5, 22,  389.90,  31.19,   9.75,  430.84, NULL),
 ('2025-08-19', '2025-08-26', 5, 24, 1207.30,  96.58,  30.18, 1334.06, NULL),
 ('2025-09-02', '2025-09-09', 5, 25,  258.40,  20.67,   6.46,  285.53, NULL),
 ('2025-09-16', '2025-09-23', 5, 28,  771.60,  61.73,  19.29,  852.62, NULL),
 ('2025-09-29', '2025-10-06', 5, 30,  640.10,  51.21,  16.00,  707.31, NULL);

-- ---------- Позиции заказов ----------
INSERT INTO sales.salesorderdetail (salesorderid, productid, orderqty, unitprice, linetotal) VALUES
 (1, 4,  1, 1700.99, 1700.99),
 (1, 26, 3,    4.99,   14.97),
 (2, 6,  1, 1364.50, 1364.50),
 (2, 12, 1,  145.75,  145.75),
 (2, 19, 4,    9.50,   38.00),
 (3, 1,  2,   34.99,   69.98),
 (3, 16, 1,   24.99,   24.99),
 (3, 24, 1,   25.00,   25.00),
 (3, 29, 3,    2.99,    8.97),
 (4, 13, 2,  175.49,  350.98),
 (4, 26, 2,    4.99,    9.98),
 (5, 5,  1, 1700.99, 1700.99),
 (5, 21, 4,    8.50,   34.00),
 (6, 17, 1,   32.60,   32.60),
 (6, 26, 4,    4.99,   19.96),
 (7, 6,  2,  1364.50, 2729.00),
 (7, 24, 1,   25.00,   25.00),
 (8, 14, 2,  100.00,  200.00),
 (8, 30, 3,    9.99,   29.97),
 (9, 1,  2,   34.99,   69.98),
 (9, 22, 3,   26.33,   78.99),
 (10, 19, 3,   9.50,   28.50),
 (10, 29, 4,   2.99,   11.96),
 (11, 7, 1,  1364.50, 1364.50),
 (12, 13, 2,  175.49,  350.98),
 (13, 22, 2,   26.33,   52.66),
 (13, 29, 2,    2.99,    5.98),
 (14, 17, 3,   32.60,   97.80),
 (15, 12, 1,  145.75,  145.75),
 (15, 28, 2,   40.00,   80.00),
 (16, 29, 3,    2.99,    8.97),
 (17, 12, 1,  145.75,  145.75),
 (17, 26, 5,    4.99,   24.95),
 (18, 14, 2,  100.00,  200.00);

-- ---------- Сотрудники ----------
INSERT INTO sales.employee (firstname, lastname, city, stateprovince, countryregion) VALUES
 ('Dan',    'Drayton',  'New York',        'New York',       'United States'),
 ('Aisha',  'Witt',     'Los Angeles',     'California',     'United States'),
 ('Rosie',  'Reeves',   'Chicago',         'Illinois',       'United States'),
 ('Naomi',  'Sharp',    'Miami',           'Florida',        'United States'),
 ('Pavel',  'Sokolov',  'Moscow',          'Moscow',         'Russia'),
 ('Irina',  'Volkova',  'Saint Petersburg','Saint Petersburg','Russia'),
 ('John',   'Baker',    'London',          'Greater London', 'United Kingdom'),
 ('Claire', 'Dubois',   'Paris',           'Ile-de-France',  'France'),
 ('Lars',   'Meyer',    'Berlin',          'Berlin',         'Germany'),
 ('Elena',  'Smirnova', 'Denver',          'Colorado',       'United States');

COMMIT;

ANALYZE;
