#01. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select apellido1, apellido2,nombre from persona where tipo= 'alumno' order by apellido1 asc;
#02. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona where tipo = lower('alumno') and telefono is null;
#03. Retorna el llistat dels alumnes que van néixer en 1999.
select apellido1, apellido2,nombre, fecha_nacimiento from persona where fecha_nacimiento like '1999%';
#04. Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
select apellido1 , apellido2 , nombre , telefono, tipo, nif from persona where nif like '%K' and tipo = lower('profesor') and telefono is null;
#05. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
select nombre as 'asignatura' from asignatura where cuatrimestre = 1 and curso= 3 and id_grado = 7; 
#06. Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select persona.apellido1 , persona.apellido2 , persona.nombre , departamento.nombre as departamento from persona right join profesor on persona.id = profesor.id_profesor inner join departamento on profesor.id_departamento = departamento.id where persona.tipo = 'profesor' order by persona.apellido1 asc;  
#07. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M.
select asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin from asignatura join curso_escolar  on asignatura.id = curso_escolar.id join alumno_se_matricula_asignatura on asignatura.id = alumno_se_matricula_asignatura.id_asignatura join persona  on alumno_se_matricula_asignatura.id_alumno = persona.id where nif = '26902806M';
#08. Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select distinct departamento.nombre as departamento from departamento inner join profesor on departamento.id = profesor.id_departamento inner join asignatura on profesor.id_profesor = asignatura.id_profesor inner join grado on asignatura.id_grado = grado.id where grado.id = 4;
#09. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select distinct persona.nombre, apellido1, apellido2, anyo_inicio, anyo_fin from persona inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id where anyo_inicio = 2018;
#select * from curso_escolar; #id5 2018/2019
select distinct persona.nombre, apellido1, apellido2, anyo_inicio, anyo_fin from persona inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id inner join asignatura on asignatura.id = alumno_se_matricula_asignatura.id_asignatura where curso_escolar.id = 5;

#Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

#01. Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
select persona.apellido1, persona.apellido2 , persona.nombre, departamento.nombre as departamento from persona left join profesor on persona.id = profesor.id_profesor left join departamento on profesor.id_departamento = departamento.id where persona.tipo = 'profesor'  order by departamento.nombre ASC;
#02. Retorna un llistat amb els professors que no estan associats a un departament.
select persona.nombre, persona.apellido1, persona.apellido2 from persona left join profesor on persona.id = profesor.id_profesor left join departamento on departamento.id = profesor.id_departamento where persona.tipo = 'profesor' and departamento.nombre is null;
-- (no entenc la pregunta per que no hi han profesors sense tenir asociat un departament, deixo l'exemple abaix..)
select * from departamento left join profesor on departamento.id = profesor.id_departamento;
#03. Retorna un llistat amb els departaments que no tenen professors associats.
select departamento.nombre from departamento left join profesor on departamento.id = profesor.id_departamento left join persona on profesor.id_profesor = persona.id where persona.nombre is null ;
#04. Retorna un llistat amb els professors que no imparteixen cap assignatura.
select persona.nombre, persona.apellido1, persona.apellido2 from persona left join profesor on persona.id = profesor.id_profesor left join asignatura on profesor.id_profesor = asignatura.id_profesor where persona.tipo = 'profesor' and asignatura.nombre is null;
#05. Retorna un llistat amb les assignatures que no tenen un professor assignat.
select asignatura.nombre from asignatura left join profesor on profesor.id_profesor = asignatura.id_profesor where asignatura.id_profesor is null; 
#06. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
select distinct departamento.nombre from departamento left join profesor on departamento.id = profesor.id_departamento left join asignatura on profesor.id_profesor = asignatura.id_profesor where asignatura.nombre is null;

#Consultes resum:

#01. Retorna el nombre total d'alumnes que hi ha.
select count(nombre) from persona where tipo= 'alumno';
#02. Calcula quants alumnes van néixer en 1999.
select count(fecha_nacimiento) as alumnos_nacidas_en_1999 from persona where fecha_nacimiento like '1999%' and tipo = 'alumno';
#03. Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
select departamento.nombre as departamento, count(persona.nombre) as numero_de_profesores from persona left join profesor on persona.id = profesor.id_profesor left join departamento on profesor.id_departamento = departamento.id where persona.tipo= 'profesor' group by departamento.nombre order by count(persona.nombre) desc;
#04. Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
select departamento.nombre as departamento, count(persona.nombre) as numero_de_profesores from departamento left join profesor on departamento.id = profesor.id_departamento left join persona on profesor.id_profesor =persona.id group by departamento.nombre order by count(persona.nombre) desc;
#05. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
select grado.nombre as nombre_grado , count(asignatura.nombre) as numero_asignaturas from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre order by count(asignatura.nombre) desc;
#06. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
select grado.nombre as nombre_grado , count(asignatura.nombre) as numero_asignaturas from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre having count(asignatura.nombre)>40 order by count(asignatura.nombre) desc;
#07. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
select distinct grado.nombre, asignatura.tipo , sum(asignatura.creditos) as creditos from grado left join asignatura on grado.id = asignatura.id_grado group by grado.nombre , asignatura.tipo order by sum(asignatura.creditos) desc;
#08. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
select anyo_inicio, count(distinct persona.nombre) as numero_matriculats from curso_escolar left join alumno_se_matricula_asignatura ama on curso_escolar.id = ama.id_curso_escolar left join persona on ama.id_alumno = persona.id group by curso_escolar.anyo_inicio;
#09. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
select persona.id, persona.nombre, persona.apellido1, persona.apellido2, count(asignatura.nombre) as numero_asignatura from persona left join profesor on persona.id = profesor.id_profesor left join asignatura on profesor.id_profesor = asignatura.id_profesor where persona.tipo = 'profesor' group by persona.nombre order by count(asignatura.nombre) desc;
#10. Retorna totes les dades de l'alumne més jove.
select * from persona left join alumno_Se_matricula_asignatura on alumno_se_matricula_asignatura.id_alumno = persona.id left join asignatura on asignatura.id = alumno_se_matricula_asignatura.id_asignatura group by alumno_se_matricula_asignatura.id_alumno order by fecha_nacimiento desc limit 1;
#11. Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.
select  persona.nombre, persona.apellido1, departamento.nombre as departamento , asignatura.nombre as asignatura  from persona left join profesor on persona.id = profesor.id_profesor left join departamento on profesor.id_departamento = departamento.id left join asignatura on profesor.id_profesor = asignatura.id_profesor where persona.tipo = 'profesor' and asignatura.nombre is null;
