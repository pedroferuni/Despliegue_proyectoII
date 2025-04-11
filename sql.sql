-- Activa la compatibilidad con FOREIGN KEY si se desean restricciones:
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;
-- Mejorar la concurrencia:
PRAGMA journal_mode = WAL;
-- 1 segundo de timeout para evitar bloqueos:
PRAGMA busy_timeout = 1000;
-- Bajo la prioridad de escritura para mejorar la concurrencia:
PRAGMA synchronous = NORMAL;

BEGIN TRANSACTION;

-- ================================================
--   TABLA: propulsion
-- ================================================
DROP TABLE IF EXISTS modelo_img;
DROP TABLE IF EXISTS modelo;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS propulsion;
DROP TABLE IF EXISTS usuarios;

CREATE TABLE propulsion (
    ID INT PRIMARY KEY,
    Nombre TEXT NOT NULL,
    Descripcion TEXT NOT NULL
);

-- Insertamos datos en la tabla 'propulsion'
INSERT INTO propulsion (ID, Nombre, Descripcion) VALUES
    (1, 'Gasolina', 'Motor de combustión interna que utiliza gasolina como combustible.'),
    (2, 'Diésel', 'Motor de combustión interna que utiliza diésel como combustible.'),
    (3, 'Híbrido', 'Automóvil que combina un motor de combustión interna con un motor eléctrico.'),
    (4, 'Eléctrico', 'Automóvil que utiliza un motor eléctrico como fuente de energía.'),
    (5, 'Hidrógeno', 'Automóvil que utiliza hidrógeno como fuente de energía.');

-- ================================================
--   TABLA: marca
-- ================================================

CREATE TABLE marca (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NOMBRE TEXT NOT NULL,
    PAIS TEXT NOT NULL,
    FUNDACION INTEGER NOT NULL,
    DESCRIPCION INTEGER NOT NULL
);

-- Insertamos datos en la tabla 'marca'
INSERT INTO marca ( ID, NOMBRE, PAIS, FUNDACION, DESCRIPCION ) VALUES
(1, 'Toyota', 'Japón', 1937, 'Una empresa japonesa de fabricación de automóviles. Fundada en 1933 por Kiichiro Toyoda.'),
(2, 'Ford', 'Estados Unidos', 1903, 'Una empresa multinacional fabricante de automóviles de origen estadounidense, destacándose principalmente por la producción de automóviles, vehículos comerciales y automóviles de carreras.'),
(3, 'BMW', 'Alemania', 1916, 'Un fabricante alemán de automóviles y motocicletas de alta gama y lujo, cuya sede se encuentra en Múnich.'),
(4, 'Honda', 'Japón', 1948, 'Fabricante japonés conocido por su producción de automóviles, motocicletas y motores de alta tecnología.'),
(5, 'Mercedes-Benz', 'Alemania', 1926, 'Marca de lujo alemana reconocida mundialmente por sus automóviles premium y de alto rendimiento.'),
(6, 'Chevrolet', 'Estados Unidos', 1911, 'Conocida como Chevy, es una marca estadounidense de automóviles y camiones, subsidiaria de General Motors.'),
(7, 'Hyundai', 'Corea del Sur', 1967, 'Fabricante surcoreano que produce automóviles asequibles y de calidad con una creciente presencia global.'),
(8, 'Nissan', 'Japón', 1933, 'Multinacional japonesa dedicada a la fabricación de automóviles y vehículos comerciales.'),
(9, 'Tesla', 'Estados Unidos', 2003, 'Pionera en la fabricación de vehículos eléctricos y en tecnologías de conducción autónoma.'),
(10, 'Ferrari', 'Italia', 1939, 'Fabricante italiano de automóviles deportivos y de lujo reconocido por su rendimiento y exclusividad.'),
(11, 'Volkswagen', 'Alemania', 1937, 'Una de las mayores empresas automotrices del mundo, conocida por modelos icónicos como el Beetle.'),
(12, 'Audi', 'Alemania', 1909, 'Fabricante de vehículos de lujo, subsidiaria de Volkswagen Group, conocida por su tecnología y diseño.'),
(13, 'Peugeot', 'Francia', 1810, 'Fabricante francés de automóviles con una rica historia en la producción de vehículos de pasajeros y comerciales.'),
(14, 'Renault', 'Francia', 1899, 'Empresa automotriz francesa destacada por sus vehículos innovadores y asequibles.'),
(15, 'Lamborghini', 'Italia', 1963, 'Fabricante italiano de automóviles deportivos de alta gama y diseño extremo.'),
(16, 'Mazda', 'Japón', 1920, 'Fabricante japonés conocido por sus vehículos confiables y su tecnología de motores rotativos.'),
(17, 'Subaru', 'Japón', 1953, 'Fabricante japonés reconocido por su sistema de tracción integral y su enfoque en la seguridad.'),
(18, 'Kia', 'Corea del Sur', 1944, 'Fabricante surcoreano que produce vehículos de gran valor y diseño atractivo.'),
(19, 'Porsche', 'Alemania', 1931, 'Fabricante alemán de automóviles deportivos de lujo y vehículos de alto rendimiento.'),
(20, 'Fiat', 'Italia', 1899, 'Uno de los fabricantes de automóviles más antiguos de Italia, conocido por sus pequeños vehículos urbanos.');


-- ================================================
--   TABLA: modelo
-- ================================================

CREATE TABLE modelo (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    NOMBRE TEXT NOT NULL,
    ID_MARCA INT NOT NULL,
    ID_PROPULSION INT NOT NULL,
    CV INTEGER NOT NULL,
    ANO INTEGER NOT NULL,
    CONSUMO REAL,   -- EN L/100KM PARA GASOLINA/DIESEL/hIBRIDOS, -- EN KWH/100KM PARA ELECTRICOS
    AUTONOMIA REAL, -- EN KM PARA ELECTRICOS
    N_PUERTAS INTEGER NOT NULL DEFAULT 5,
    DESC TEXT,
    FOREIGN KEY (ID_MARCA) REFERENCES marca(ID),
    FOREIGN KEY (ID_PROPULSION) REFERENCES propulsion(ID)
);

CREATE UNIQUE INDEX idx_modelo_nombre ON modelo (NOMBRE);
CREATE INDEX idx_modelo_propulsion ON modelo (ID_PROPULSION);

-- Insertamos datos en la tabla 'modelo'
INSERT INTO modelo (
    ID,
    NOMBRE, 
    ID_MARCA, 
    ID_PROPULSION, 
    CV,
    ANO,
    DESC,
    CONSUMO,
    AUTONOMIA,
    N_PUERTAS
) VALUES
(1, 'Corolla', 1, 1, 120, 2022, 'Un sedán confiable y eficiente, ideal para el uso diario.', 6.8, NULL, 4),
(2, 'Camry', 1, 3, 208, 2023, 'Un sedán híbrido de alta calidad con excelente rendimiento.', 4.2, NULL, 4),
(3, 'RAV4', 1, 4, 302, 2023, 'Un SUV eléctrico con gran potencia y espacio interior.', 18.0, 450, 5),
(4, 'Focus', 2, 2, 150, 2021, 'Un compacto versátil con un eficiente motor diésel.', 5.9, NULL, 4),
(5, 'Mustang', 2, 1, 450, 2022, 'Un icónico muscle car con motor de alto rendimiento.', 12.5, NULL, 2),
(6, 'F-150 Lightning', 2, 4, 563, 2023, 'Una camioneta eléctrica potente y versátil.', 23.0, 370, 4),
(7, 'i3', 3, 4, 170, 2023, 'Un automóvil eléctrico compacto y elegante.', 15.0, 260, 4),
(8, 'Serie 3', 3, 2, 190, 2022, 'Un sedán premium con un eficiente motor diésel.', 6.2, NULL, 4),
(9, 'X5', 3, 5, 389, 2023, 'Un SUV híbrido enchufable de lujo con gran rendimiento.', 2.8, NULL, 5),
(10, 'Civic', 4, 1, 158, 2022, 'Un sedán compacto confiable y con diseño moderno.', 6.4, NULL, 4),
(11, 'Accord', 4, 3, 204, 2023, 'Un sedán híbrido ideal para la eficiencia y comodidad.', 4.5, NULL, 4),
(12, 'CR-V', 4, 5, 212, 2023, 'Un SUV híbrido enchufable espacioso y eficiente.', 2.6, NULL, 5),
(13, 'A4', 12, 1, 201, 2022, 'Un sedán de lujo con excelente tecnología y diseño.', 6.0, NULL, 4),
(14, 'Q5', 12, 2, 231, 2023, 'Un SUV diésel de lujo con gran capacidad y estilo.', 5.5, NULL, 5),
(15, 'e-tron', 12, 4, 402, 2023, 'Un SUV eléctrico premium con tecnología avanzada.', 20.0, 400, 5),
(16, 'Golf', 11, 1, 130, 2022, 'Un hatchback confiable con diseño icónico.', 5.8, NULL, 4),
(17, 'Passat', 11, 2, 190, 2023, 'Un sedán diésel ideal para largos viajes.', 5.2, NULL, 4),
(18, 'ID.4', 11, 4, 201, 2023, 'Un SUV eléctrico con gran autonomía y estilo.', 19.0, 480, 5),
(19, 'Model S', 9, 4, 1020, 2023, 'Un sedán eléctrico de lujo con alto rendimiento.', 21.0, 610, 4),
(20, 'Model 3', 9, 4, 450, 2023, 'Un sedán eléctrico asequible y tecnológico.', 16.0, 560, 4),
(21, 'Model Y', 9, 4, 384, 2023, 'Un SUV eléctrico con gran capacidad y autonomía.', 17.0, 540, 5),
(22, 'C-HR', 1, 3, 184, 2023, 'Un SUV híbrido compacto y de diseño futurista.', 4.8, NULL, 5),
(23, 'Yaris', 1, 1, 116, 2022, 'Un subcompacto eficiente y fácil de manejar.', 5.6, NULL, 4),
(24, 'Hilux', 1, 2, 204, 2023, 'Una camioneta diésel robusta y confiable.', 8.5, NULL, 4),
(25, 'Explorer', 2, 3, 318, 2023, 'Un SUV híbrido con gran capacidad de carga.', 4.9, NULL, 5),
(26, 'Ranger', 2, 2, 210, 2023, 'Una camioneta diésel versátil y poderosa.', 7.8, NULL, 4),
(27, 'Bronco', 2, 1, 310, 2023, 'Un todoterreno icónico con motor potente.', 13.0, NULL, 3),
(28, 'Serie 5', 3, 1, 184, 2023, 'Un sedán de lujo con gran confort y potencia.', 6.3, NULL, 4),
(29, 'X3', 3, 2, 190, 2023, 'Un SUV compacto premium con motor diésel.', 5.7, NULL, 5),
(30, 'Z4', 3, 1, 258, 2022, 'Un roadster deportivo con diseño elegante.', 8.3, NULL, 2),
(31, 'Jazz', 4, 3, 109, 2022, 'Un compacto híbrido práctico y eficiente.', 3.9, NULL, 5),
(32, 'HR-V', 4, 3, 131, 2023, 'Un SUV híbrido compacto con estilo moderno.', 4.1, NULL, 5),
(33, 'Pilot', 4, 1, 280, 2023, 'Un SUV grande ideal para viajes familiares.', 10.1, NULL, 5),
(34, 'A3', 12, 1, 150, 2023, 'Un compacto premium con tecnología avanzada.', 6.1, NULL, 4),
(35, 'Q7', 12, 2, 286, 2023, 'Un SUV de lujo con gran espacio interior.', 7.2, NULL, 5),
(36, 'RS e-tron GT', 12, 4, 646, 2023, 'Un sedán eléctrico deportivo y de alto rendimiento.', 22.0, 450, 4),
(37, 'Tiguan', 11, 2, 150, 2022, 'Un SUV compacto versátil y confiable.', 6.0, NULL, 5),
(38, 'Polo', 11, 1, 110, 2023, 'Un subcompacto eficiente con diseño clásico.', 5.3, NULL, 4),
(39, 'Arteon', 11, 5, 218, 2023, 'Un sedán híbrido enchufable elegante y potente.', 2.7, NULL, 5),
(40, 'Cybertruck', 9, 4, 800, 2023, 'Una camioneta eléctrica futurista y robusta.', 25.0, 500, 4),
(41, 'Roadster', 9, 4, 1000, 2023, 'Un deportivo eléctrico con velocidad extrema.', 24.0, 620, 2),
(42, 'Semi', 9, 4, 1100, 2023, 'Un camión eléctrico innovador y eficiente.', 30.0, 800, 2),
(43, 'Huracán EVO', 15, 1, 640, 2023, 'Un superdeportivo con diseño agresivo y potente.', 14.0, NULL, 2),
(44, 'Aventador SVJ', 15, 1, 770, 2021, 'Un superdeportivo exclusivo con gran potencia.', 15.5, NULL, 2),
(45, 'Urus', 15, 1, 650, 2023, 'Un SUV deportivo de lujo con motor poderoso.', 12.5, NULL, 5),
(46, '911 Carrera', 19, 1, 385, 2022, 'Un deportivo clásico con excelente rendimiento.', 11.2, NULL, 2),
(47, 'Taycan', 19, 4, 408, 2023, 'Un sedán eléctrico premium y tecnológico.', 21.0, 500, 4),
(48, 'Cayenne', 19, 5, 462, 2023, 'Un SUV híbrido enchufable de lujo y gran capacidad.', 3.2, NULL, 5);


-- ================================================
--   TABLA: modelo_img
-- ================================================

CREATE TABLE modelo_img (
    ID INTEGER PRIMARY KEY AUTOINCREMENT,
    ID_MODELO INTEGER NOT NULL,
    PATH TEXT NOT NULL--,
    --FOREIGN KEY (ID_MODELO) REFERENCES modelo(ID)
);


-- Insertamos datos en la tabla 'modelo_img'
-- Insertamos datos en la tabla 'modelo_img'
INSERT INTO modelo_img (ID_MODELO, PATH) VALUES
(1, '/img/toyota/corolla_0.jpg'),
(1, '/img/toyota/corolla_1.jpg'),
(2, '/img/toyota/camry_0.jpg'),
(3, '/img/toyota/rav4_0.jpg'),
(4, '/img/ford/focus_0.jpg'),
(5, '/img/ford/mustang_0.jpg'),
(6, '/img/ford/f150_lightning_0.jpg'),
(7, '/img/bmw/i3_0.jpg'),
(8, '/img/bmw/serie3_0.jpg'),
(9, '/img/bmw/x5_0.jpg'),
(10, '/img/honda/civic_0.jpg'),
(11, '/img/honda/accord_0.jpg'),
(12, '/img/honda/crv_0.jpg'),
(13, '/img/audi/a4_0.jpg'),
(14, '/img/audi/q5_0.jpg'),
(15, '/img/audi/etron_0.jpg'),
(16, '/img/volkswagen/golf_0.jpg'),
(17, '/img/volkswagen/passat_0.jpg'),
(18, '/img/volkswagen/id4_0.jpg'),
(19, '/img/tesla/models_0.jpg'),
(20, '/img/tesla/model3_0.jpg'),
(21, '/img/tesla/modely_0.jpg'),
(22, '/img/toyota/chr_0.jpg'),
(23, '/img/toyota/yaris_0.jpg'),
(24, '/img/toyota/hilux_0.jpg'),
(25, '/img/ford/explorer_0.jpg'),
(26, '/img/ford/ranger_0.jpg'),
(27, '/img/ford/bronco_0.jpg'),
(28, '/img/bmw/serie5_0.jpg'),
(29, '/img/bmw/x3_0.jpg'),
(30, '/img/bmw/z4_0.jpg'),
(31, '/img/honda/jazz_0.jpg'),
(32, '/img/honda/hrv_0.jpg'),
(33, '/img/honda/pilot_0.jpg'),
(34, '/img/audi/a3_0.jpg'),
(35, '/img/audi/q7_0.jpg'),
(36, '/img/audi/rs_etron_gt_0.jpg'),
(37, '/img/volkswagen/tiguan_0.jpg'),
(38, '/img/volkswagen/polo_0.jpg'),
(39, '/img/volkswagen/arteon_0.jpg'),
(40, '/img/tesla/cybertruck_0.jpg'),
(41, '/img/tesla/roadster_0.jpg'),
(42, '/img/tesla/semi_0.jpg'),
(43, '/img/lamborghini/huracan_evo_0.jpg'),
(44, '/img/lamborghini/aventador_svj_0.jpg'),
(45, '/img/lamborghini/urus_0.jpg'),
(46, '/img/porsche/911_carrera_0.jpg'),
(47, '/img/porsche/taycan_0.jpg'),
(48, '/img/porsche/cayenne_0.jpg'),
(49, '/img/kia/sportage_0.jpg'),
(50, '/img/kia/sorento_0.jpg'),
(51, '/img/kia/ev6_0.jpg'),
(52, '/img/mazda/mx5_0.jpg'),
(53, '/img/mazda/cx5_0.jpg'),
(54, '/img/mazda/mazda3_0.jpg'),
(55, '/img/subaru/outback_0.jpg'),
(56, '/img/subaru/forester_0.jpg'),
(57, '/img/subaru/impreza_0.jpg'),
(58, '/img/renault/clio_0.jpg'),
(59, '/img/renault/megane_etech_0.jpg'),
(60, '/img/renault/captur_0.jpg'),
(61, '/img/ferrari/488_pista_0.jpg'),
(62, '/img/ferrari/sf90_stradale_0.jpg'),
(63, '/img/ferrari/roma_0.jpg'),
(64, '/img/mercedes/cclass_0.jpg'),
(65, '/img/mercedes/eclass_0.jpg'),
(66, '/img/mercedes/sclass_0.jpg'),
(67, '/img/mercedes/glc_0.jpg'),
(68, '/img/mercedes/gle_0.jpg'),
(69, '/img/mercedes/aclass_0.jpg'),
(70, '/img/mercedes/eqc_0.jpg'),
(71, '/img/mercedes/glb_0.jpg'),
(72, '/img/mercedes/amg_gt_0.jpg');


-- ================================================
--   TABLA: usuarios
-- ================================================

CREATE TABLE usuarios (
    EMAIL TEXT PRIMARY KEY NOT NULL,
    SESION TEXT,
    NOMBRE TEXT NOT NULL,
    PASS TEXT NOT NULL, -- md5
    F_NACIMIENTO TEXT NOT NULL,  -- Se usa TEXT para la fecha ie '1980-04-28'
    DIRECCION TEXT NOT NULL,
    CP INT NOT NULL,
    PROVINCIA TEXT NOT NULL
);


-- Insertamos datos en la tabla 'usuarios'
INSERT INTO usuarios ( NOMBRE, PASS, EMAIL, F_NACIMIENTO, DIRECCION, CP, PROVINCIA ) VALUES
    ( 'Juan Perez', 			'34913d570b9e50f929fbe6d9198283d9', 'juan.perez@gmail.com', '1980-04-28', 'Calle Mayor 123', 28013, 'Madrid'),
    ( 'Ana Gómez', 			'34913d570b9e50f929fbe6d9198283d9', 'ana.gomez@hotmail.com', '1992-07-15', 'Avenida del Sol 45', 41001, 'Sevilla'),
    ( 'Carlos López', 			'34913d570b9e50f929fbe6d9198283d9', 'carlos.lopez@yahoo.com', '1975-02-10', 'Calle Luna 67', 29001, 'Málaga'),
    ( 'María Fernández', 			'34913d570b9e50f929fbe6d9198283d9', 'maria.fernandez@outlook.com', '1988-11-22', 'Plaza Central 9', 08001, 'Barcelona'),
    ( 'ADMIN', 			'34913d570b9e50f929fbe6d9198283d9', 'admin@admin.com', '2000-01-01', 'Edificio Central 1', 15001, 'A Coruña'),
    ( 'Luis Torres', 			'34913d570b9e50f929fbe6d9198283d9', 'luis.torres@gmail.com', '1985-03-10', 'Calle Verde 23', 15001, 'A Coruña'),
    ( 'Sofía Martínez', 			'34913d570b9e50f929fbe6d9198283d9', 'sofia.martinez@yahoo.es', '1995-09-25', 'Avenida de la Paz 17', 30008, 'Murcia'),
    ( 'Javier Núñez', 			'34913d570b9e50f929fbe6d9198283d9', 'javier.nunez@hotmail.com', '1978-12-18', 'Calle Mar 12', 18001, 'Granada'),
    ( 'Lucía Ortiz', 			'34913d570b9e50f929fbe6d9198283d9', 'lucia.ortiz@outlook.com', '1987-06-15', 'Calle Río 45', 26005, 'Logroño'),
    ( 'Andrés Gutiérrez', 			'34913d570b9e50f929fbe6d9198283d9', 'andres.gutierrez@gmail.com', '1983-11-07', 'Calle Sol 8', 47002, 'Valladolid'),
    ( 'Paula Vega', 			'34913d570b9e50f929fbe6d9198283d9', 'paula.vega@outlook.com', '1991-01-12', 'Avenida Luna 98', 31001, 'Pamplona'),
    ( 'Miguel Ángel Ruiz', 			'34913d570b9e50f929fbe6d9198283d9', 'miguel.ruiz@yahoo.com', '1990-10-22', 'Calle Estrella 77', 20004, 'San Sebastián'),
    ( 'Laura Navarro', 			'34913d570b9e50f929fbe6d9198283d9', 'laura.navarro@gmail.com', '1982-04-30', 'Calle Mayor 88', 50001, 'Zaragoza'),
    ( 'Patricia Ramos', 			'34913d570b9e50f929fbe6d9198283d9', 'patricia.ramos@hotmail.com', '1989-03-18', 'Calle Azul 29', 24007, 'León');

-- Índices equivalentes para la tabla 'usuarios'
CREATE UNIQUE INDEX idx_usuarios_email ON usuarios (EMAIL);
CREATE UNIQUE INDEX idx_usuarios_sesion ON usuarios (SESION);

COMMIT;
