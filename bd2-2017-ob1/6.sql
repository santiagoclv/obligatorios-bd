-- 6. Devolver el identificador, título y cantidad de actores (cant_actores)
-- de películas tales que no hay otra película que tiene costo de reemplazo
-- mayor que ella y con la cual comparte actores.

SELECT p."idPelicula", p.titulo, COUNT(*) cant_actores
FROM peliculas p
INNER JOIN "actoresDePeliculas" a
ON a."idPelicula" = p."idPelicula"
LEFT JOIN "actoresDePeliculas" aa
ON aa."idPelicula" = p."idPelicula" AND exists (
 					SELECT *
 					FROM "actoresDePeliculas" aaa 
    				INNER JOIN peliculas pp
					ON aaa."idPelicula" = pp."idPelicula"
 					WHERE pp."costoReemplazo" > p."costoReemplazo" AND
 					aaa."idActor" = aa."idActor")
WHERE aa."idPelicula" IS null
GROUP BY p."idPelicula", p.titulo
ORDER BY p."idPelicula";