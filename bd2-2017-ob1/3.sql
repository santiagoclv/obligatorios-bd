-- 3. Para cada película que ha sido alquilada devolver el identificador de la misma y
-- la duración del alquiler más reciente (duración). Tener en cuenta que puede existir
-- más de un alquiler en la fecha más reciente, en cuyo caso se desea devolver la máxima 
-- duración de ese conjunto de alquileres. Para los alquileres que no han sido devueltos
-- la duración a devolver corresponde al tiempo transcurrido entre la fecha de alquiler
-- y el momento en que se realiza la consulta.

SELECT a."idPelicula", MAX(CASE WHEN a."fechaDevolucion" is null THEN now() - a."fecha" ELSE  a."fechaDevolucion" - a."fecha"  END) as duracion
FROM alquileres a
WHERE a."fecha" = (SELECT MAX(aa."fecha") FROM alquileres aa WHERE a."idPelicula" = aa."idPelicula" GROUP BY aa."idPelicula")
GROUP BY a."idPelicula", a."fecha"
ORDER BY a."idPelicula";