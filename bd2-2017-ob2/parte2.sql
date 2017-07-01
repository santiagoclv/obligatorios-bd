CREATE TABLE balances (
	id_cliente integer,
	fecha_calculo timestamp,
	saldo numeric
);

CREATE OR REPLACE FUNCTION balance_cliente( client integer, fecha_alq timestamp with time zone) RETURNS numeric AS $$
DECLARE
 resultado numeric DEFAULT 0;
 tiempo_alq numeric DEFAULT 0;
 rec_cliente RECORD;
 cur_cliente CURSOR(cliente_id integer, fecha_alq timestamp) 
 FOR SELECT a."fechaDevolucion", a."fecha", pp."costoReemplazo", pp."costoAlquiler", pp."duracionAlquiler", p.monto
 FROM alquileres a
 INNER JOIN peliculas pp
 ON pp."idPelicula" = a."idPelicula"
 LEFT JOIN pagos p
 ON p."idPeliculaAlquilo" = a."idPelicula"
 AND p."idClienteAlquilo" = a."idCliente"
 AND p."idSucursalAlquilo" = a."idSucursal"
 AND p."idPersonalAlquilo" = a."idPersonal"
 AND p."fechaAlquilo" = a.fecha
 WHERE a."idCliente" = cliente_id
 AND a.fecha <= fecha_alq;
BEGIN
   OPEN cur_cliente(client, fecha_alq);
   LOOP
      FETCH cur_cliente INTO rec_cliente;
      EXIT WHEN NOT FOUND;
      
      resultado := resultado + rec_cliente."costoAlquiler";
      
      IF rec_cliente."fechaDevolucion" is null THEN 
        tiempo_alq := EXTRACT(DAY FROM (fecha_alq - rec_cliente."fecha"));
      ELSE  
	tiempo_alq := EXTRACT(DAY FROM (rec_cliente."fechaDevolucion" - rec_cliente."fecha"));
      END IF;

      IF (tiempo_alq - rec_cliente."duracionAlquiler") > 0  THEN 
	resultado := resultado + (tiempo_alq - rec_cliente."duracionAlquiler") * 5; 
      END IF;

      IF tiempo_alq > (rec_cliente."duracionAlquiler" * 3)  THEN 
	resultado := resultado + rec_cliente."costoReemplazo"; 
      END IF;
            
      IF rec_cliente.monto is not null THEN 
         resultado := resultado - rec_cliente.monto;
      END IF;

      tiempo_alq := 0;
   END LOOP;
   
   CLOSE cur_cliente;
 
   RETURN resultado;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION balance_clientes( fecha_alqs timestamp with time zone) RETURNS text AS $$
DECLARE
 resultado text DEFAULT 'OK';
 rec_clientes RECORD;
 cur_clientes CURSOR
 FOR SELECT c."idCliente"
 FROM clientes c;
BEGIN
   OPEN cur_clientes;
   LOOP
      FETCH cur_clientes INTO rec_clientes;
      EXIT WHEN NOT FOUND;
      
      INSERT INTO balances (id_cliente,	fecha_calculo, saldo)
      VALUES (rec_clientes."idCliente", fecha_alqs , balance_cliente(rec_clientes."idCliente", fecha_alqs));
      
   END LOOP;
   
   CLOSE cur_clientes;
 
   RETURN resultado;
END;
$$ LANGUAGE plpgsql;