-- 5. Devolver el identificador, nombre y apellido de empleados activos que trabajan en la sucursal
-- con mayor cantidad de alquileres, pero que nunca recibieron el pago de ningún alquiler.

SELECT e."idPersonal", e.nombre, e.apellido
FROM personal e
WHERE e.activo 
	   AND e."idSucursal" IN (SELECT c."idSucursal"ç
                               FROM (SELECT a."idSucursal", count(*) "cantAlq"
                                     FROM alquileres a 
                                     GROUP BY a."idSucursal")  c
                              WHERE c."cantAlq" = (SELECT MAX(c."cantAlq")
                                                   FROM (SELECT a."idSucursal", count(*) "cantAlq"
                                                         FROM alquileres a 
                                                         GROUP BY a."idSucursal")  c))
       AND e."idPersonal" NOT IN (select "idPersonalRecibePago" from pagos);