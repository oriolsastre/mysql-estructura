SELECT nombre AS nom FROM producto ORDER BY Nom ASC;
SELECT nombre AS Nom, precio AS Preu FROM producto ORDER BY Nom ASC;
DESCRIBE producto;
SELECT nombre AS Nom, precio AS 'Preu en €', ROUND(precio*0.97,2) AS 'Preu en $' FROM producto;
SELECT nombre AS 'nom de producto', precio AS 'euros', ROUND(precio*0.97,2) AS 'dòlars' FROM producto;
SELECT UPPER(nombre), precio FROM producto;
SELECT LOWER(nombre), precio FROM producto;
SELECT fabricante.nombre AS 'Nom del Fabricant', UPPER(LEFT(nombre,2)) FROM fabricante;
SELECT nombre AS 'Nom', ROUND(precio) AS 'Preu arrodonit' FROM producto;
SELECT nombre AS 'Nom', TRUNCATE(precio,0) AS 'Preu truncat' FROM producto;
SELECT codigo_fabricante AS 'Codi del Fabricant' FROM producto;
SELECT DISTINCT(codigo_fabricante) AS 'Codi del Fabricant' FROM producto;
SELECT nombre FROM fabricante ORDER BY nombre ASC;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre AS 'Nom' FROM producto ORDER BY nombre ASC, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 2 OFFSET 3;
SELECT nombre AS 'Nom', precio AS 'Preu' FROM producto ORDER BY precio ASC LIMIT 1;
SELECT nombre AS 'Nom', precio AS 'Preu' FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre AS 'Nom del producte' FROM producto WHERE codigo_fabricante=2;
SELECT producto.nombre AS 'Nom del producte', precio AS 'Preu', fabricante.nombre AS 'Nom del fabricant' FROM producto JOIN fabricante ON codigo_fabricante=fabricante.codigo;
SELECT producto.nombre AS 'Nom del producte', precio AS 'Preu', fabricante.nombre AS 'Nom del fabricant' FROM producto JOIN fabricante ON codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre ASC;


/*----Universitat----*/
/*01*/ SELECT apellido1 AS 'Primer cognom', apellido2 AS 'Segon cognom', nombre AS 'Nom' FROM persona WHERE tipo='alumno' ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
/*02*/ SELECT nombre AS 'Nom', apellido1 AS '1er cognom', apellido2 AS '2n cognom' FROM persona WHERE tipo='alumno' AND telefono IS NULL;
/*03*/ SELECT nombre AS 'Nom', apellido1 AS '1er cognom', apellido2 AS '2n cognom' FROM persona WHERE tipo='alumno' AND YEAR(fecha_nacimiento)=1999;
/*04*/ SELECT nombre AS 'Nom', apellido1 AS '1er cognom', apellido2 AS '2n cognom' FROM persona WHERE tipo='profesor' AND telefono IS NULL AND RIGHT(nif,1)='K';
/*05*/ SELECT id, nombre AS 'Assignatura' FROM asignatura WHERE curso=3 AND cuatrimestre=1 AND id_grado=7;
/*06*/ SELECT apellido1 AS '1er cognom', apellido2 '2n cognom', persona.nombre AS 'Nom', departamento.nombre AS 'Departament' FROM persona JOIN profesor ON persona.id=id_profesor JOIN departamento ON id_departamento=departamento.id ORDER BY apellido1 ASC, apellido2 ASC, persona.nombre ASC;
/*07*/ SELECT asignatura.nombre AS 'Assignatura', anyo_inicio AS "Any d'inici", anyo_fin AS 'Any de fi' FROM persona JOIN alumno_se_matricula_asignatura ON persona.id=id_alumno JOIN curso_escolar ON id_curso_escolar=curso_escolar.id JOIN asignatura ON id_asignatura=asignatura.id WHERE persona.tipo='alumno' AND nif='26902806M';
/*08*/ SELECT DISTINCT(departamento.nombre) AS 'Departament' FROM departamento JOIN profesor ON departamento.id=id_departamento JOIN asignatura ON asignatura.id_profesor=profesor.id_profesor WHERE id_grado=4;
/*09*/ SELECT persona.nombre AS 'Nom', apellido1 AS '1er cognom', apellido2 AS '2n cognom' FROM persona JOIN alumno_se_matricula_asignatura ON persona.id=id_alumno  WHERE id_curso_escolar=5 AND persona.tipo = 'alumno' GROUP BY persona.id;
/*--Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.--*/
/*01*/ SELECT departamento.nombre AS 'Departament', apellido1 AS '1er cognom', apellido2 AS '2n cognom', persona.nombre AS 'Nom' FROM persona LEFT JOIN (profesor JOIN departamento ON id_departamento=departamento.id) ON persona.id=id_profesor WHERE persona.tipo='profesor' ORDER BY departamento.nombre ASC, apellido1 ASC, apellido2 ASC, persona.nombre ASC;
/*02*/ SELECT nombre AS 'Nom', apellido1 AS '1er cognom', apellido2 AS '2n cognom' FROM persona LEFT JOIN profesor ON persona.id=id_profesor WHERE persona.tipo='profesor' AND id_departamento IS NULL;
/*03*/ SELECT nombre AS 'Departament' FROM profesor RIGHT JOIN departamento ON id_departamento=departamento.id WHERE id_profesor IS NULL;
/*04*/ SELECT persona.nombre AS 'Nom', apellido1 AS '1er cognom', apellido2 AS '2n cognom' FROM persona LEFT JOIN asignatura ON persona.id=id_profesor WHERE persona.tipo='profesor' AND asignatura.id IS NULL;
/*05*/ SELECT asignatura.nombre AS 'Assignatura' FROM asignatura WHERE id_profesor IS NULL;
/*06*/ SELECT departamento.nombre AS 'Departament' FROM departamento LEFT JOIN profesor ON departamento.id=id_departamento LEFT JOIN asignatura ON profesor.id_profesor=asignatura.id_profesor WHERE asignatura.id IS NULL GROUP BY departamento.id;
/*----Consultes resum----*/
/*01*/ SELECT COUNT(id) AS "Total d'alumnes" FROM persona WHERE tipo='alumno';
/*02*/ SELECT COUNT(id) AS "Total d'alumnes nascuts al 99" FROM persona WHERE tipo='alumno' AND YEAR(fecha_nacimiento)=1999;
/*03*/ SELECT departamento.nombre AS 'Departament', COUNT(id_profesor) AS 'Num. de professors' FROM profesor JOIN departamento ON id_departamento=departamento.id GROUP BY departamento.id ORDER BY 2 DESC;
/*04*/ SELECT departamento.nombre AS 'Departament', COUNT(id_profesor) AS 'Num. de professors' FROM profesor RIGHT JOIN departamento ON id_departamento=departamento.id GROUP BY departamento.id;
/*05*/ SELECT grado.nombre AS 'Grau', COUNT(asignatura.id) AS 'Num. Assignatures' FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.id ORDER BY 2 DESC;
/*06*/ SELECT grado.nombre AS 'Grau', COUNT(asignatura.id) AS Assignatures FROM grado LEFT JOIN asignatura ON grado.id=asignatura.id_grado GROUP BY grado.id HAVING COUNT(asignatura.id)>40;
/*07*/ SELECT grado.nombre AS 'Grau', asignatura.tipo AS "Tipus d'Assignatura", SUM(creditos) AS 'Suma de crèdits' FROM grado JOIN asignatura ON grado.id=id_grado GROUP BY id_grado, asignatura.tipo;
/*08*/ SELECT anyo_inicio AS 'Inici del curs escolar', COUNT(DISTINCT(id_alumno)) AS 'Alumnes matriculats' FROM alumno_se_matricula_asignatura JOIN curso_escolar ON id_curso_escolar=id GROUP BY anyo_inicio;
/*09*/ SELECT persona.id, persona.nombre AS 'Nom', apellido1 AS '1er Cognom', apellido2 AS '2n Cognom', COUNT(asignatura.id) AS "Num. d'Assignatures" FROM persona LEFT JOIN asignatura ON persona.id=id_profesor WHERE persona.tipo='profesor' GROUP BY persona.id ORDER BY COUNT(asignatura.id) DESC;
/*10*/ SELECT * FROM persona WHERE tipo='alumno' ORDER BY fecha_nacimiento DESC LIMIT 1;
/*11*/ SELECT persona.nombre AS 'Nom', apellido1 AS '1er Cognom', apellido2 AS '2n Cognom' FROM (persona JOIN profesor ON persona.id=profesor.id_profesor) LEFT JOIN asignatura ON persona.id=asignatura.id_profesor GROUP BY persona.id HAVING COUNT(asignatura.id)=0;