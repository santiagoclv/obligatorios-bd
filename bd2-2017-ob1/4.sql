-- 4.  Devolver el identificador de las sucursales que poseen más socios que el promedio 
-- de socios por sucursal pero que tienen registrados menos alquileres que el promedio 
-- de cantidad de alquileres por sucursal.

SELECT c."idSucursal"
FROM clientes c
GROUP BY c."idSucursal"
HAVING count(*) > (SELECT AVG(cc."cantidadClientes") "promedioClientes" 
					FROM  (SELECT count(*) "cantidadClientes"
							FROM clientes c
							GROUP BY c."idSucursal") cc)
INTERSECT
SELECT a."idSucursal"
FROM alquileres a
GROUP BY a."idSucursal"
HAVING count(*) < (SELECT AVG(aa."cantidadAlquileres") "promedioAlquileres" 
 					FROM  (SELECT count(*) "cantidadAlquileres"
        					FROM alquileres a
        					GROUP BY a."idSucursal") aa);