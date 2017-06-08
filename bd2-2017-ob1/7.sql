-- 7. Devolver identificador, nombre y apellido de aquellos clientes que han alquilado todas las películas
-- que se encuentran en las sucursales de la ciudad donde vive.
-- Tener en cuenta que los alquileres pueden haber sido realizados en sucursales
-- que no estén ubicadas en la ciudad donde vive el cliente.

SELECT c."idCliente", c.nombre, c.apellido
FROM clientes c
LEFT JOIN alquileres a
ON a."idCliente" = c."idCliente" 
	AND a."idPelicula" in  (SELECT i."idPelicula"
    					   FROM inventario i
    					   INNER JOIN sucursales s
    						ON i."idSucursal" = s."idSucursal"
    						WHERE s."idCiudad" = c."idCiudad")
WHERE a."idPelicula" IS NOT null
GROUP BY c."idCliente", c.nombre, c.apellido
HAVING count(*) = (SELECT COUNT(cant.*) FROM (SELECT ii."idPelicula"
    									FROM inventario ii
    									INNER JOIN sucursales ss
    									ON ii."idSucursal" = ss."idSucursal"
    									WHERE ss."idCiudad" = c."idCiudad"
    									GROUP BY ii."idPelicula") cant);