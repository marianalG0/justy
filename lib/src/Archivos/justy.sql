-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-06-2023 a las 04:01:16
-- Versión del servidor: 10.4.25-MariaDB
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `justy`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `numControl` char(10) NOT NULL,
  `idPersona` int(11) DEFAULT NULL,
  `idGrupo` int(11) DEFAULT NULL,
  `semestre` text DEFAULT NULL,
  `turno` text DEFAULT NULL,
  `especialidad` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`numControl`, `idPersona`, `idGrupo`, `semestre`, `turno`, `especialidad`) VALUES
('0981234587', 6, 2, 'Sexto', 'Matutino', 'Recursos Humanos'),
('1234567891', 2, 3, '6', 'Vespertino', 'Recursos Humanos'),
('2135678942', 3, 3, '8', 'fefefe', 'col'),
('3456789098', 6, 3, 'j', 'j', 'k');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docentes`
--

CREATE TABLE `docentes` (
  `idDoc` int(11) NOT NULL,
  `materia` varchar(45) DEFAULT NULL,
  `idPersona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `docentes`
--

INSERT INTO `docentes` (`idDoc`, `materia`, `idPersona`) VALUES
(1, 'Física', 7),
(4, 'gg', 5),
(5, 'mate ', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupo`
--

CREATE TABLE `grupo` (
  `id` int(11) NOT NULL,
  `nomenclatura` varchar(10) DEFAULT NULL,
  `aula` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `grupo`
--

INSERT INTO `grupo` (`id`, `nomenclatura`, `aula`) VALUES
(1, '6AMPR', 3),
(2, '6AMRH', 9),
(3, '3AMPR', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grupodoc`
--

CREATE TABLE `grupodoc` (
  `idgrupoDoc` int(11) NOT NULL,
  `idGrupo` int(11) DEFAULT NULL,
  `idDoc` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `grupodoc`
--

INSERT INTO `grupodoc` (`idgrupoDoc`, `idGrupo`, `idDoc`) VALUES
(1, 2, 1),
(2, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellidoP` varchar(45) DEFAULT NULL,
  `apellidoM` varchar(45) DEFAULT NULL,
  `telefono` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `nombre`, `apellidoP`, `apellidoM`, `telefono`) VALUES
(1, 'Ma', 'García', 'Hau', '9874563210'),
(2, 'Erika', 'Hernandez', 'May', '6352417896'),
(3, 'Camila', 'Sanchez', 'Chi', '3214569874'),
(4, 'Melanie', 'Puc', 'Balam', '2514789654'),
(5, 'Edward', 'López', 'Zapata', '2147483647'),
(6, 'Marta', 'Chavez', 'Santos', '3020104578'),
(7, 'Noé', 'Solís', 'May', '9831143819'),
(8, 'Zunne', 'Poot', 'Lima', '9831145277');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`) VALUES
(1, 'Mariana', '1234'),
(3, 'Noé', '4321'),
(4, 'Erika', '2468'),
(5, 'Edward ', 'lalo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`numControl`),
  ADD KEY `idPersona` (`idPersona`),
  ADD KEY `idGrupo` (`idGrupo`);

--
-- Indices de la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD PRIMARY KEY (`idDoc`),
  ADD KEY `per_id` (`idPersona`);

--
-- Indices de la tabla `grupo`
--
ALTER TABLE `grupo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `grupodoc`
--
ALTER TABLE `grupodoc`
  ADD PRIMARY KEY (`idgrupoDoc`),
  ADD KEY `idGrupo` (`idGrupo`),
  ADD KEY `idDoc` (`idDoc`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `docentes`
--
ALTER TABLE `docentes`
  MODIFY `idDoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `grupo`
--
ALTER TABLE `grupo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `grupodoc`
--
ALTER TABLE `grupodoc`
  MODIFY `idgrupoDoc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `alumno_ibfk_2` FOREIGN KEY (`idGrupo`) REFERENCES `grupo` (`id`);

--
-- Filtros para la tabla `docentes`
--
ALTER TABLE `docentes`
  ADD CONSTRAINT `docentes_ibfk_1` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`);

--
-- Filtros para la tabla `grupodoc`
--
ALTER TABLE `grupodoc`
  ADD CONSTRAINT `grupodoc_ibfk_1` FOREIGN KEY (`idGrupo`) REFERENCES `grupo` (`id`),
  ADD CONSTRAINT `grupodoc_ibfk_2` FOREIGN KEY (`idGrupo`) REFERENCES `grupo` (`id`),
  ADD CONSTRAINT `grupodoc_ibfk_3` FOREIGN KEY (`idDoc`) REFERENCES `docentes` (`idDoc`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
