-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-04-2021 a las 03:42:13
-- Versión del servidor: 10.4.8-MariaDB
-- Versión de PHP: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `minimarket`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ACTUALIZAR_CLIENTE` (`_rut` VARCHAR(12), `_nombre` VARCHAR(30), `paterno` VARCHAR(20), `materno` VARCHAR(20), `tel` VARCHAR(20), `_correo` VARCHAR(20), `sexo` TINYINT, `tipo` TINYINT, `_calle` VARCHAR(45), `num` INT, `comuna` INT)  BEGIN

UPDATE registro_cliente

	SET Nombre = _nombre,
    	Apellido_Paterno = paterno,
        Apellido_Materno = materno,
        Telefono = tel,
        Correo = _correo,
        Id_Sexo = sexo,
        Id_Tipo_Cliente = tipo
    WHERE Rut = _rut;
    
    
UPDATE direccion

	SET Calle = _calle,
    	Numero = num,
        Id_Comuna = comuna
        

	WHERE Rut_Cliente = _rut;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AGREGAR_CLIENTE` (IN `rut` VARCHAR(12), IN `nombre` VARCHAR(30), IN `paterno` VARCHAR(20), IN `materno` VARCHAR(20), IN `telefono` VARCHAR(20), IN `correo` VARCHAR(45), IN `calle` VARCHAR(45), IN `numero` INT, IN `idComuna` INT, IN `tipo` TINYINT, IN `sexo` TINYINT)  BEGIN

IF (BUSCAR_CLIENTE(rut)=1) THEN
SIGNAL SQLSTATE '40004'SET MESSAGE_TEXT = 'ESTE USUARIO YA EXISTE';
 ELSE
INSERT INTO registro_cliente (Rut,Nombre,Apellido_Paterno,Apellido_Materno,Telefono, Correo, Estado,Id_Tipo_Cliente,Id_Sexo) values (rut, nombre, paterno, materno, telefono,correo,1,tipo,sexo);
INSERT INTO direccion (Rut_Cliente, Calle, Numero, Id_Comuna) values (rut, calle, numero, idComuna);
END IF ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ELIMINAR_CLIENTE` (IN `rut_c` VARCHAR(12))  BEGIN

UPDATE registro_cliente

 SET ESTADO = 0
 
 WHERE Rut = rut_c;

END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `BUSCAR_CLIENTE` (`rut_c` VARCHAR(12)) RETURNS INT(11) BEGIN

DECLARE CONTADOR INT DEFAULT 0;

SELECT COUNT(*) INTO CONTADOR 
FROM registro_cliente WHERE Rut = rut_c;

RETURN CONTADOR;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `clientes`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `clientes` (
`Rut` varchar(12)
,`Nombre` varchar(30)
,`Apellido_Paterno` varchar(20)
,`Apellido_Materno` varchar(20)
,`Telefono` varchar(20)
,`Correo` varchar(45)
,`Calle` varchar(45)
,`Numero` int(11)
,`Comuna` varchar(45)
,`Id_Comuna` int(10)
,`Id_Region` int(11)
,`Region` varchar(45)
,`Tipo` varchar(10)
,`Id_Tipo` tinyint(4)
,`Estado` tinyint(4)
,`Sexo` varchar(10)
,`Id_Sexo` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comunas`
--

CREATE TABLE `comunas` (
  `Id_Comuna` int(10) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Id_Region` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `comunas`
--

INSERT INTO `comunas` (`Id_Comuna`, `Nombre`, `Id_Region`) VALUES
(1, 'Arica', 1),
(2, 'Camarones', 1),
(3, 'General Lagos', 1),
(4, 'Putre', 1),
(5, 'Alto Hospicio', 2),
(6, 'Iquique', 2),
(7, 'Camiña', 2),
(8, 'Colchane', 2),
(9, 'Huara', 2),
(10, 'Pica', 2),
(11, 'Pozo Almonte', 2),
(12, 'Antofagasta', 3),
(13, 'Mejillones', 3),
(14, 'Sierra Gorda', 3),
(15, 'Taltal', 3),
(16, 'Calama', 3),
(17, 'Ollague', 3),
(18, 'San Pedro de Atacama', 3),
(19, 'María Elena', 3),
(20, 'Tocopilla', 3),
(21, 'Chañaral', 4),
(22, 'Diego de Almagro', 4),
(23, 'Caldera', 4),
(24, 'Copiapó', 4),
(25, 'Tierra Amarilla', 4),
(26, 'Alto del Carmen', 4),
(27, 'Freirina', 4),
(28, 'Huasco', 4),
(29, 'Vallenar', 4),
(30, 'Canela', 5),
(31, 'Illapel', 5),
(32, 'Los Vilos', 5),
(33, 'Salamanca', 5),
(34, 'Andacollo', 5),
(35, 'Coquimbo', 5),
(36, 'La Higuera', 5),
(37, 'La Serena', 5),
(38, 'Paihuaco', 5),
(39, 'Vicuña', 5),
(40, 'Combarbalá', 5),
(41, 'Monte Patria', 5),
(42, 'Ovalle', 5),
(43, 'Punitaqui', 5),
(44, 'Río Hurtado', 5),
(45, 'Isla de Pascua', 6),
(46, 'Calle Larga', 6),
(47, 'Los Andes', 6),
(48, 'Rinconada', 6),
(49, 'San Esteban', 6),
(50, 'La Ligua', 6),
(51, 'Papudo', 6),
(52, 'Petorca', 6),
(53, 'Zapallar', 6),
(54, 'Hijuelas', 6),
(55, 'La Calera', 6),
(56, 'La Cruz', 6),
(57, 'Limache', 6),
(58, 'Nogales', 6),
(59, 'Olmué', 6),
(60, 'Quillota', 6),
(61, 'Algarrobo', 6),
(62, 'Cartagena', 6),
(63, 'El Quisco', 6),
(64, 'El Tabo', 6),
(65, 'San Antonio', 6),
(66, 'Santo Domingo', 6),
(67, 'Catemu', 6),
(68, 'Llaillay', 6),
(69, 'Panquehue', 6),
(70, 'Putaendo', 6),
(71, 'San Felipe', 6),
(72, 'Santa María', 6),
(73, 'Casablanca', 6),
(74, 'Concón', 6),
(75, 'Juan Fernández', 6),
(76, 'Puchuncaví', 6),
(77, 'Quilpué', 6),
(78, 'Quintero', 6),
(79, 'Valparaíso', 6),
(80, 'Villa Alemana', 6),
(81, 'Viña del Mar', 6),
(82, 'Colina', 7),
(83, 'Lampa', 7),
(84, 'Tiltil', 7),
(85, 'Pirque', 7),
(86, 'Puente Alto', 7),
(87, 'San José de Maipo', 7),
(88, 'Buin', 7),
(89, 'Calera de Tango', 7),
(90, 'Paine', 7),
(91, 'San Bernardo', 7),
(92, 'Alhué', 7),
(93, 'Curacaví', 7),
(94, 'María Pinto', 7),
(95, 'Melipilla', 7),
(96, 'San Pedro', 7),
(97, 'Cerrillos', 7),
(98, 'Cerro Navia', 7),
(99, 'Conchalí', 7),
(100, 'El Bosque', 7),
(101, 'Estación Central', 7),
(102, 'Huechuraba', 7),
(103, 'Independencia', 7),
(104, 'La Cisterna', 7),
(105, 'La Granja', 7),
(106, 'La Florida', 7),
(107, 'La Pintana', 7),
(108, 'La Reina', 7),
(109, 'Las Condes', 7),
(110, 'Lo Barnechea', 7),
(111, 'Lo Espejo', 7),
(112, 'Lo Prado', 7),
(113, 'Macul', 7),
(114, 'Maipú', 7),
(115, 'Ñuñoa', 7),
(116, 'Pedro Aguirre Cerda', 7),
(117, 'Peñalolén', 7),
(118, 'Providencia', 7),
(119, 'Pudahuel', 7),
(120, 'Quilicura', 7),
(121, 'Quinta Normal', 7),
(122, 'Recoleta', 7),
(123, 'Renca', 7),
(124, 'San Miguel', 7),
(125, 'San Joaquín', 7),
(126, 'San Ramón', 7),
(127, 'Santiago', 7),
(128, 'Vitacura', 7),
(129, 'El Monte', 7),
(130, 'Isla de Maipo', 7),
(131, 'Padre Hurtado', 7),
(132, 'Peñaflor', 7),
(133, 'Talagante', 7),
(134, 'Codegua', 8),
(135, 'Coínco', 8),
(136, 'Coltauco', 8),
(137, 'Doñihue', 8),
(138, 'Graneros', 8),
(139, 'Las Cabras', 8),
(140, 'Machalí', 8),
(141, 'Malloa', 8),
(142, 'Mostazal', 8),
(143, 'Olivar', 8),
(144, 'Peumo', 8),
(145, 'Pichidegua', 8),
(146, 'Quinta de Tilcoco', 8),
(147, 'Rancagua', 8),
(148, 'Rengo', 8),
(149, 'Requínoa', 8),
(150, 'San Vicente de Tagua Tagua', 8),
(151, 'La Estrella', 8),
(152, 'Litueche', 8),
(153, 'Marchihue', 8),
(154, 'Navidad', 8),
(155, 'Peredones', 8),
(156, 'Pichilemu', 8),
(157, 'Chépica', 8),
(158, 'Chimbarongo', 8),
(159, 'Lolol', 8),
(160, 'Nancagua', 8),
(161, 'Palmilla', 8),
(162, 'Peralillo', 8),
(163, 'Placilla', 8),
(164, 'Pumanque', 8),
(165, 'San Fernando', 8),
(166, 'Santa Cruz', 8),
(167, 'Cauquenes', 9),
(168, 'Chanco', 9),
(169, 'Pelluhue', 9),
(170, 'Curicó', 9),
(171, 'Hualañé', 9),
(172, 'Licantén', 9),
(173, 'Molina', 9),
(174, 'Rauco', 9),
(175, 'Romeral', 9),
(176, 'Sagrada Familia', 9),
(177, 'Teno', 9),
(178, 'Vichuquén', 9),
(179, 'Colbún', 9),
(180, 'Linares', 9),
(181, 'Longaví', 9),
(182, 'Parral', 9),
(183, 'Retiro', 9),
(184, 'San Javier', 9),
(185, 'Villa Alegre', 9),
(186, 'Yerbas Buenas', 9),
(187, 'Constitución', 9),
(188, 'Curepto', 9),
(189, 'Empedrado', 9),
(190, 'Maule', 9),
(191, 'Pelarco', 9),
(192, 'Pencahue', 9),
(193, 'Río Claro', 9),
(194, 'San Clemente', 9),
(195, 'San Rafael', 9),
(196, 'Talca', 9),
(197, 'Bulnes', 10),
(198, 'Chillán', 10),
(199, 'Chillán Viejo', 10),
(200, 'Cobquecura', 10),
(201, 'Coelemu', 10),
(202, 'Coihueco', 10),
(203, 'El Carmen', 10),
(204, 'Ninhue', 10),
(205, 'Ñiquen', 10),
(206, 'Pemuco', 10),
(207, 'Pinto', 10),
(208, 'Portezuelo', 10),
(209, 'Quirihue', 10),
(210, 'Ránquil', 10),
(211, 'Treguaco', 10),
(212, 'Quillón', 10),
(213, 'San Carlos', 10),
(214, 'San Fabián', 10),
(215, 'San Ignacio', 10),
(216, 'San Nicolás', 10),
(217, 'Yungay', 10),
(218, 'Arauco', 11),
(219, 'Cañete', 11),
(220, 'Contulmo', 11),
(221, 'Curanilahue', 11),
(222, 'Lebu', 11),
(223, 'Los Álamos', 11),
(224, 'Tirúa', 11),
(225, 'Alto Biobío', 11),
(226, 'Antuco', 11),
(227, 'Cabrero', 11),
(228, 'Laja', 11),
(229, 'Los Ángeles', 11),
(230, 'Mulchén', 11),
(231, 'Nacimiento', 11),
(232, 'Negrete', 11),
(233, 'Quilaco', 11),
(234, 'Quilleco', 11),
(235, 'San Rosendo', 11),
(236, 'Santa Bárbara', 11),
(237, 'Tucapel', 11),
(238, 'Yumbel', 11),
(239, 'Chiguayante', 11),
(240, 'Concepción', 11),
(241, 'Coronel', 11),
(242, 'Florida', 11),
(243, 'Hualpén', 11),
(244, 'Hualqui', 11),
(245, 'Lota', 11),
(246, 'Penco', 11),
(247, 'San Pedro de La Paz', 11),
(248, 'Santa Juana', 11),
(249, 'Talcahuano', 11),
(250, 'Tomé', 11),
(251, 'Carahue', 12),
(252, 'Cholchol', 12),
(253, 'Cunco', 12),
(254, 'Curarrehue', 12),
(255, 'Freire', 12),
(256, 'Galvarino', 12),
(257, 'Gorbea', 12),
(258, 'Lautaro', 12),
(259, 'Loncoche', 12),
(260, 'Melipeuco', 12),
(261, 'Nueva Imperial', 12),
(262, 'Padre Las Casas', 12),
(263, 'Perquenco', 12),
(264, 'Pitrufquén', 12),
(265, 'Pucón', 12),
(266, 'Saavedra', 12),
(267, 'Temuco', 12),
(268, 'Teodoro Schmidt', 12),
(269, 'Toltén', 12),
(270, 'Vilcún', 12),
(271, 'Villarrica', 12),
(272, 'Angol', 12),
(273, 'Collipulli', 12),
(274, 'Curacautín', 12),
(275, 'Ercilla', 12),
(276, 'Lonquimay', 12),
(277, 'Los Sauces', 12),
(278, 'Lumaco', 12),
(279, 'Purén', 12),
(280, 'Renaico', 12),
(281, 'Traiguén', 12),
(282, 'Victoria', 12),
(283, 'Corral', 13),
(284, 'Lanco', 13),
(285, 'Los Lagos', 13),
(286, 'Máfil', 13),
(287, 'Mariquina', 13),
(288, 'Paillaco', 13),
(289, 'Panguipulli', 13),
(290, 'Valdivia', 13),
(291, 'Futrono', 13),
(292, 'La Unión', 13),
(293, 'Lago Ranco', 13),
(294, 'Río Bueno', 13),
(295, 'Ancud', 14),
(296, 'Castro', 14),
(297, 'Chonchi', 14),
(298, 'Curaco de Vélez', 14),
(299, 'Dalcahue', 14),
(300, 'Puqueldón', 14),
(301, 'Queilén', 14),
(302, 'Quemchi', 14),
(303, 'Quellón', 14),
(304, 'Quinchao', 14),
(305, 'Calbuco', 14),
(306, 'Cochamó', 14),
(307, 'Fresia', 14),
(308, 'Frutillar', 14),
(309, 'Llanquihue', 14),
(310, 'Los Muermos', 14),
(311, 'Maullín', 14),
(312, 'Puerto Montt', 14),
(313, 'Puerto Varas', 14),
(314, 'Osorno', 14),
(315, 'Puero Octay', 14),
(316, 'Purranque', 14),
(317, 'Puyehue', 14),
(318, 'Río Negro', 14),
(319, 'San Juan de la Costa', 14),
(320, 'San Pablo', 14),
(321, 'Chaitén', 14),
(322, 'Futaleufú', 14),
(323, 'Hualaihué', 14),
(324, 'Palena', 14),
(325, 'Aisén', 15),
(326, 'Cisnes', 15),
(327, 'Guaitecas', 15),
(328, 'Cochrane', 15),
(329, 'O\'higgins', 15),
(330, 'Tortel', 15),
(331, 'Coihaique', 15),
(332, 'Lago Verde', 15),
(333, 'Chile Chico', 15),
(334, 'Río Ibáñez', 15),
(335, 'Antártica', 16),
(336, 'Cabo de Hornos', 16),
(337, 'Laguna Blanca', 16),
(338, 'Punta Arenas', 16),
(339, 'Río Verde', 16),
(340, 'San Gregorio', 16),
(341, 'Porvenir', 16),
(342, 'Primavera', 16),
(343, 'Timaukel', 16),
(344, 'Natales', 16),
(345, 'Torres del Paine', 16),
(346, 'Cabildo', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `direccion`
--

CREATE TABLE `direccion` (
  `Id_Direccion` int(11) NOT NULL,
  `Id_Comuna` int(11) NOT NULL,
  `Calle` varchar(45) NOT NULL,
  `Numero` int(11) NOT NULL,
  `Rut_Cliente` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `direccion`
--

INSERT INTO `direccion` (`Id_Direccion`, `Id_Comuna`, `Calle`, `Numero`, `Rut_Cliente`) VALUES
(12, 79, 'Por ahi', 45, '10287917-1'),
(13, 295, 'Las Acasias ', 27, '13282762-1'),
(22, 80, '18 de Septiembre', 18, '16091033-K');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `region`
--

CREATE TABLE `region` (
  `Id_Region` int(11) NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `region`
--

INSERT INTO `region` (`Id_Region`, `Nombre`) VALUES
(1, 'Arica y Parinacota'),
(2, 'Tarapacá'),
(3, 'Antofagasta'),
(4, 'Atacama'),
(5, 'Coquimbo'),
(6, 'Valparaíso'),
(7, 'Metropolitana'),
(8, 'Libertador General Bernardo O\'Higgins'),
(9, 'Maule'),
(10, 'Ñuble'),
(11, 'Biobio'),
(12, 'La Araucanía'),
(13, 'Los Ríos'),
(14, 'Los Lagos'),
(15, 'Aisén del General Carlos Ibañez del Campo'),
(16, 'Magallanes y de la Antártica Chilena');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_cliente`
--

CREATE TABLE `registro_cliente` (
  `Rut` varchar(12) NOT NULL,
  `Id_Tipo_Cliente` tinyint(1) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Apellido_Paterno` varchar(20) NOT NULL,
  `Apellido_Materno` varchar(20) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Correo` varchar(45) NOT NULL,
  `Estado` tinyint(4) NOT NULL DEFAULT 1,
  `Id_Sexo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `registro_cliente`
--

INSERT INTO `registro_cliente` (`Rut`, `Id_Tipo_Cliente`, `Nombre`, `Apellido_Paterno`, `Apellido_Materno`, `Telefono`, `Correo`, `Estado`, `Id_Sexo`) VALUES
('10287917-1', 1, 'Juan', 'Antonio', 'Higuaino', '7845457', 'jala23@gmail.com', 1, 1),
('13282762-1', 1, 'Juana', 'Antonia', '3213', '7845457', 'juanita@gmail.com', 1, 2),
('16091033-K', 1, 'Soledad', 'Santiago', 'Hidalgo', '45124784', 'sol@gmail.com', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sexo`
--

CREATE TABLE `sexo` (
  `Id_Sexo` tinyint(1) NOT NULL,
  `Sex` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `sexo`
--

INSERT INTO `sexo` (`Id_Sexo`, `Sex`) VALUES
(1, 'Masculino'),
(2, 'Femenino'),
(3, 'Otro');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_cliente`
--

CREATE TABLE `tipo_cliente` (
  `Id_Tipo_Cliente` tinyint(4) NOT NULL,
  `Tipo` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tipo_cliente`
--

INSERT INTO `tipo_cliente` (`Id_Tipo_Cliente`, `Tipo`) VALUES
(1, 'Persona'),
(2, 'Empresa');

-- --------------------------------------------------------

--
-- Estructura para la vista `clientes`
--
DROP TABLE IF EXISTS `clientes`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `clientes`  AS  select `registro_cliente`.`Rut` AS `Rut`,`registro_cliente`.`Nombre` AS `Nombre`,`registro_cliente`.`Apellido_Paterno` AS `Apellido_Paterno`,`registro_cliente`.`Apellido_Materno` AS `Apellido_Materno`,`registro_cliente`.`Telefono` AS `Telefono`,`registro_cliente`.`Correo` AS `Correo`,`direccion`.`Calle` AS `Calle`,`direccion`.`Numero` AS `Numero`,`comunas`.`Nombre` AS `Comuna`,`comunas`.`Id_Comuna` AS `Id_Comuna`,`region`.`Id_Region` AS `Id_Region`,`region`.`Nombre` AS `Region`,`tipo_cliente`.`Tipo` AS `Tipo`,`tipo_cliente`.`Id_Tipo_Cliente` AS `Id_Tipo`,`registro_cliente`.`Estado` AS `Estado`,`sexo`.`Sex` AS `Sexo`,`sexo`.`Id_Sexo` AS `Id_Sexo` from (((((`registro_cliente` join `tipo_cliente` on(`registro_cliente`.`Id_Tipo_Cliente` = `tipo_cliente`.`Id_Tipo_Cliente`)) join `direccion` on(`registro_cliente`.`Rut` = `direccion`.`Rut_Cliente`)) join `comunas` on(`direccion`.`Id_Comuna` = `comunas`.`Id_Comuna`)) join `region` on(`comunas`.`Id_Region` = `region`.`Id_Region`)) join `sexo` on(`sexo`.`Id_Sexo` = `registro_cliente`.`Id_Sexo`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comunas`
--
ALTER TABLE `comunas`
  ADD PRIMARY KEY (`Id_Comuna`),
  ADD KEY `Id_Region` (`Id_Region`);

--
-- Indices de la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD PRIMARY KEY (`Id_Direccion`),
  ADD KEY `Id_Comuna` (`Id_Comuna`),
  ADD KEY `Rut_Cliente` (`Rut_Cliente`);

--
-- Indices de la tabla `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`Id_Region`);

--
-- Indices de la tabla `registro_cliente`
--
ALTER TABLE `registro_cliente`
  ADD PRIMARY KEY (`Rut`),
  ADD KEY `Id_Tipo_Cliente` (`Id_Tipo_Cliente`),
  ADD KEY `Id_Sexo` (`Id_Sexo`);

--
-- Indices de la tabla `sexo`
--
ALTER TABLE `sexo`
  ADD PRIMARY KEY (`Id_Sexo`);

--
-- Indices de la tabla `tipo_cliente`
--
ALTER TABLE `tipo_cliente`
  ADD PRIMARY KEY (`Id_Tipo_Cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comunas`
--
ALTER TABLE `comunas`
  MODIFY `Id_Comuna` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=347;

--
-- AUTO_INCREMENT de la tabla `direccion`
--
ALTER TABLE `direccion`
  MODIFY `Id_Direccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `comunas`
--
ALTER TABLE `comunas`
  ADD CONSTRAINT `comunas_ibfk_1` FOREIGN KEY (`Id_Region`) REFERENCES `region` (`Id_Region`);

--
-- Filtros para la tabla `direccion`
--
ALTER TABLE `direccion`
  ADD CONSTRAINT `direccion_ibfk_1` FOREIGN KEY (`Id_Comuna`) REFERENCES `comunas` (`Id_Comuna`),
  ADD CONSTRAINT `direccion_ibfk_2` FOREIGN KEY (`Rut_Cliente`) REFERENCES `registro_cliente` (`Rut`);

--
-- Filtros para la tabla `registro_cliente`
--
ALTER TABLE `registro_cliente`
  ADD CONSTRAINT `registro_cliente_ibfk_1` FOREIGN KEY (`Id_Tipo_Cliente`) REFERENCES `tipo_cliente` (`Id_Tipo_Cliente`),
  ADD CONSTRAINT `registro_cliente_ibfk_2` FOREIGN KEY (`Id_Sexo`) REFERENCES `sexo` (`Id_Sexo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
