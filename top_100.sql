-- 1. Crear base de datos llamada películas 
CREATE DATABASE peliculas;

-- 2. Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas. 

CREATE TABLE peliculas(
id SERIAL,
pelicula VARCHAR(80) NOT NULL,
año_estreno INT NOT NULL,
director VARCHAR(50) NOT NULL,
PRIMARY KEY (id));

CREATE TABLE reparto(
pelicula_id INT,
actor_actriz VARCHAR(50) NOT NULL,
FOREIGN KEY (pelicula_id) REFERENCES
peliculas(id));

-- 3. Cargar ambos archivos a su tabla correspondiente
-- ruta utilizada desde mi PC
COPY peliculas FROM '/home/danielid/Escritorio/Curso/Base_datos/peliculas.csv' CSV header;
COPY reparto FROM '/home/danielid/Escritorio/Curso/Base_datos/reparto.csv' CSV;

-- 4. Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película, año de estreno, director y todo el reparto. 
SELECT pelicula, año_estreno, director, actor_actriz FROM peliculas INNER JOIN reparto ON peliculas.id=reparto.pelicula_id AND pelicula='Titanic';

-- 5. Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula FROM peliculas INNER JOIN reparto ON peliculas.id=reparto.pelicula_id AND actor_actriz='Harrison Ford';

-- 6. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el top 100.
SELECT director, COUNT(*) AS cantidad_peliculas FROM peliculas GROUP BY director ORDER BY cantidad_peliculas DESC LIMIT 10;

-- 7. Indicar cuantos actores distintos hay
SELECT COUNT(DISTINCT actor_actriz) FROM reparto;

-- 8. Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por título de manera ascendente.
SELECT pelicula FROM peliculas WHERE año_estreno>1989 AND año_estreno<2000 ORDER BY pelicula ASC;

-- 9. Listar el reparto de las películas lanzadas el año 2001 
SELECT actor_actriz FROM reparto INNER JOIN peliculas ON reparto.pelicula_id=peliculas.id AND año_estreno=2001;

-- 10. Listar los actores de la película más nueva 
SELECT actor_actriz FROM reparto INNER JOIN peliculas ON reparto.pelicula_id=peliculas.id WHERE año_estreno=(SELECT MAX(año_estreno) FROM peliculas);