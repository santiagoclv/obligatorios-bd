-- 8. Devolver identificador y nombre de actores que han participado en películas 
-- con clasificación NC-17 de todas las categorias conocidas

SELECT a."idActor", a.nombre
FROM actores a
WHERE NOT EXISTS (
	(	(SELECT DISTINCT ca."idCategoria"
        FROM categorias ca)
     	EXCEPT
        (SELECT DISTINCT caP."idCategoria"
        	FROM peliculas p
			INNER JOIN "actoresDePeliculas" ap
			ON p."idPelicula" = ap."idPelicula"
         	INNER JOIN "categoriasDePeliculas" caP
			ON p."idPelicula" = caP."idPelicula"
     		WHERE p.clasificacion = 'NC-17' AND ap."idActor" = a."idActor")
    )
);
