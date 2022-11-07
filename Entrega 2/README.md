## Comentaris d'algunes consultes

4. He usat el valor d'€ a \$ de 1€=0,97$ el dia 20221103 12:29.

### Universitat

1.7. Si en sabem el NIF és que ja sabem qui és, però he afegit la clàusula `persona.tipo='alumno'` per si per coses hi hagués un professor amb el mateix nif, ja sigui per error, o perquè el professor està matriculat com a alumne en un altre departament.

1.8. Suposo que ho havíem de fer així i he mirat quin id tenia el grau que ens has dit. Sinó es podria haver afegit un JOIN amb la taula grado i afegir clàsules amb paraules claus com `grado.nombre LIKE ('%Informática%') AND grado.nombre LIKE ('%Plan 2015%')` si no sabem el nom exacte del grau.

1.9. Com en el cas 1.7, la clàusula `persona.tipo='alumno'` potser és superflua amb les dades actuals. I semblant a l'1.8 he buscat la id del curs escolar 2018/2019 però es podria haver fet un join amb la taula curso_escolar i buscar inici=2018 i final=2019.

2.4. Faig el LEFT JOIN directament amb la taula asignatures així ja capturo també els profesors que no tenen cap departament associat.

2.5. No entenc la necessitat de fer cap JOIN.

3.8. Com que cap de les columnes a la taula alumno_se_matricula_asignatura pot ser _NULL_, tots els alumnes que hi apareixen estan matriculats d'alguna asignatura.