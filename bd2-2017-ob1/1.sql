-- 1. Devolver el identificador de los clientes que, habiendo alquilado películas, sólo alquilaron películas en la sucursal donde se hicieron socios.

SELECT DISTINCT c."idCliente"
FROM clientes c
INNER JOIN alquileres a1
ON a1."idSucursal" = c."idSucursal"
   AND a1."idCliente" = c."idCliente"
WHERE NOT EXISTS  (
    	SELECT a2."idSucursal"
    	FROM alquileres a2
    	WHERE a2."idCliente" = c."idCliente"
    		   AND a2."idSucursal" <> c."idSucursal")
ORDER BY c."idCliente";