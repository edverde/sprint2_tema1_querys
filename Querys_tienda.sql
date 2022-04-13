#Llista el nom de tots els productos que hi ha en la taula producto.
SELECT nombre FROM producto;
#Llista els noms i els preus de tots els productos de la taula producto.
SELECT nombre, precio FROM producto;
#Llista totes les columnes de la taula producto.
SELECT * FROM producto;
#Llista el nom dels productos, el preu en euros i el preu en dòlars nord-americans (USD).
SELECT nombre , precio AS 'Precio €', FORMAT(precio*1.10,2) AS 'Precio $' FROM producto;
#Llista el nom dels productos, el preu en euros i el preu en dòlars nord-americans. Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars nord-americans.
SELECT nombre as 'nom_de_producto', CONCAT(precio, '€') AS 'euros' , CONCAT(TRUNCATE(precio*1.10,2), '$') AS 'dòlars_nord-americans' FROM producto;
#Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a majúscula.
SELECT upper(nombre) as 'Nombre', CONCAT(precio,'€') AS Precio FROM producto;
#Llista els noms i els preus de tots els productos de la taula producto, convertint els noms a minúscula.
SELECT lower(nombre) as 'Nombre', CONCAT(precio,'€') AS Precio FROM producto;
#Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre as 'normal', concat(Upper(LEFT(nombre,2)), LOWER(SUBSTRING(nombre,3))) AS '2 Mayusculas' FROM fabricante;
#Llista els noms i els preus de tots els productos de la taula producto, arrodonint el valor del preu.
SELECT nombre, CONCAT(round(precio),'€') AS precio FROM producto;
#Llista els noms i els preus de tots els productos de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, CONCAT(truncate(precio,0),'€') AS 'precio' FROM producto;
#Llista el codi dels fabricants que tenen productos en la taula producto.fabricante
SELECT codigo_fabricante , nombre FROM producto;
#Llista el codi dels fabricants que tenen productos en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo_fabricante FROM producto;
#Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM producto ORDER BY nombre ASC;
#Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM producto ORDER BY nombre DESC;
#Llista els noms dels productos ordenats en primer lloc pel nom de manera ascendent i en segon lloc pel preu de manera descendent.
SELECT nombre , precio FROM producto ORDER BY nombre ASC , precio DESC;
#Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 0, 5;
#Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3 , 2;
#Llista el nom i el preu del producto més barat. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY
SELECT  nombre, concat(precio , '€') as coste FROM producto ORDER BY precio ASC LIMIT 1 ;
#Llista el nom i el preu del producto més car. (Utilitzi solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT  nombre, concat(precio , '€') as coste FROM producto ORDER BY precio DESC LIMIT 1 ;
#Llista el nom de tots els productos del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante = 2;
#Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT producto.nombre , concat(precio,'€') AS coste , fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ;
#Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordeni el resultat pel nom del fabricant, per ordre alfabètic.
SELECT producto.nombre, concat(precio,'€') AS coste, fabricante.nombre as fabricante FROM producto  INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ORDER BY fabricante.nombre ASC;
#Retorna una llista amb el codi del producte, nom del producte, codi del fabricant i nom del fabricant, de tots els productes de la base de dades.
SELECT producto.codigo AS id, producto.nombre, fabricante.codigo, fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante;
#Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT producto.nombre , producto.precio, fabricante.nombre AS Fabricante FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ORDER BY precio ASC LIMIT 1;
#Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT producto.nombre , producto.precio, fabricante.nombre AS fabricante FROM producto INNER JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante ORDER BY precio DESC LIMIT 1;
#Retorna una llista de tots els productes del fabricant Lenovo.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON  producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante = 2;
#Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200€.
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante= fabricante.codigo where codigo_fabricante = 6 and precio >=200;
#Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante = 1 || codigo_fabricante = 3 || codigo_fabricante = 5;
#Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Utilitzant l'operador IN.
SELECT producto.nombre, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante IN (1,3,5);
#Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';
#Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';
#Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180€. Ordeni el resultat en primer lloc pel preu (en ordre descendent) i en segon lloc pel nom (en ordre ascendent)
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FRom producto JOIN fabricante ON  producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;
#Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT DISTINCT fabricante.codigo, fabricante.nombre AS Fabricante FROM fabricante INNER JOIN producto ON producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante;
#Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT fabricante.nombre AS Fabricante , producto.nombre FROM fabricante LEFT JOIN producto ON producto.codigo_fabricante = fabricante.codigo;
#Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT fabricante.nombre AS fabricante , producto.nombre FRom fabricante LEFT JOIN producto ON producto.codigo_fabricante = fabricante.codigo WHERE producto.nombre IS NULL;
#Retorna tots els productes del fabricant Lenovo. (Sense utilitzar INNER JOIN).
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM fabricante RIGHT JOIN producto ON  producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante = 2;
#Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense utilitzar INNER JOIN).
SELECT producto.nombre, producto.precio, fabricante.nombre AS fabricante FROM fabricante RIGHT JOIN producto ON  producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = 559;
#Llista el nom del producte més car del fabricant Lenovo.
SELECt producto.nombre FROM fabricante RIGHT join producto ON producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante= 2 ORDER BY precio desc limit 1; 
#Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT producto.nombre FROM fabricante RIGHT join producto ON producto.codigo_fabricante = fabricante.codigo WHERE codigo_fabricante= 3 ORDER BY precio asc limit 1;
#Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE  producto.precio >=559;
#Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT producto.nombre , producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON  producto.codigo_fabricante = fabricante.codigo WHERE fabricante.codigo = 1 AND precio > ( SELECT avg(all producto.precio) FROM producto  WHERE codigo_fabricante = 1 );
SELECT * from producto;

