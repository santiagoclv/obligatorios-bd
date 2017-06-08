-- 2. Obtener las parejas de sucursales (idSucursal1, idSucursal2) que tienen exactamente las mismas películas,
-- sin considerar la cantidad de ejemplares que existen en cada una de ellas.
-- ATENCION: no deben devolverse parejas simétricas.
SELECT DISTINCT i."idSucursal", ii."idSucursal"
FROM inventario i
INNER JOIN inventario ii
ON i."idPelicula" = ii."idPelicula" AND
	i."idSucursal" < ii."idSucursal"
WHERE NOT EXISTS
    (((SELECT i1."idPelicula"
          FROM inventario i1
          WHERE i1."idSucursal" = i."idSucursal")
      UNION 
      (SELECT i2."idPelicula"
          FROM inventario i2
          WHERE i2."idSucursal" = ii."idSucursal"))
     EXCEPT
       ((SELECT i3."idPelicula"
          FROM inventario i3
          WHERE i3."idSucursal" = i."idSucursal")
       INTERSECT
       (SELECT i4."idPelicula"
          FROM inventario i4
          WHERE i4."idSucursal" = ii."idSucursal")
        ));