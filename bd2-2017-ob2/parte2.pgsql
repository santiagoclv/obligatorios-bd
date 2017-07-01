-- Acción Dado un cliente (id_cliente) y una fecha (fecha) calcula el saldo de cuenta del cliente a esa fecha.
-- El estado de cuenta de un cliente se compone de:  
-- 1- La suma de los costos de alquiler de todos los alquileres realizados ANTES de la fecha de cálculo. 
-- 2- Un recargo de $5 por cada dia de atraso1 de los alquileres considerados en el punto 1.
-- 3- Si el atraso es mayor al triple de la duracion_alquiler se le debe cobrar el costo de reemplazo de la película.
-- 4 - Descontar todos los pagos que el cliente haya realizado ANTES de la fecha de cálculo.  

-- Nombre Función: balance_clientes  Parámetros:  Entrada:  fecha (timestamp)  
-- Acción Recorre la tabla clientes y para cada uno de ellos invoca la función balance_cliente.
-- Por cada invocación inserta una tupla en la tabla balances con el cliente (id_cliente), la fecha de cálculo (fecha) y el saldo calculado.  

CREATE TABLE balances (
	id_cliente integer,
	fecha_calculo timestamp,
	saldo numeric
);



CREATE OR REPLACE FUNCTION balance_cliente( client integer, fecha_alq timestamp with time zone) RETURNS TEXT AS $$
DECLARE
 resultado TEXT DEFAULT '';
 rec_cliente RECORD;
 cur_cliente CURSOR(cliente_id integer, fecha_alq timestamp) 
 FOR SELECT *
 FROM alquileres
 WHERE "idCliente" = cliente_id AND 
 fecha <= fecha_alq;
BEGIN
   OPEN cur_cliente(client, fecha_alq);
   LOOP
      FETCH cur_cliente INTO rec_cliente;
      EXIT WHEN NOT FOUND;
      
      IF rec_cliente."idPelicula" > 1 THEN 
         resultado := resultado || ',' || rec_cliente."idPelicula" || ':' || rec_cliente.fecha;
      END IF;
   END LOOP;
   
   CLOSE cur_cliente;
 
   RETURN resultado;
END;
$$ LANGUAGE plpgsql;


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