-- Acción Dado un cliente (id_cliente) y una fecha (fecha) calcula el saldo de cuenta del cliente a esa fecha.
-- El estado de cuenta de un cliente se compone de:  
-- 1- La suma de los costos de alquiler de todos los alquileres realizados ANTES de la fecha de cálculo. 
-- 2- Un recargo de $5 por cada dia de atraso1 de los alquileres considerados en el punto 1.
-- 3- Si el atraso es mayor al triple de la duracion_alquiler se le debe cobrar el costo de reemplazo de la película.
-- 4 - Descontar todos los pagos que el cliente haya realizado ANTES de la fecha de cálculo.  

-- Nombre Función: balance_clientes  Parámetros:  Entrada:  fecha (timestamp)  
-- Acción Recorre la tabla clientes y para cada uno de ellos invoca la función balance_cliente.
-- Por cada invocación inserta una tupla en la tabla balances con el cliente (id_cliente), la fecha de cálculo (fecha) y el saldo calculado.  

CREATE TABLE balances {
	id_cliente integer,
	fecha_calculo timestamp,
	saldo numeric
};

CREATE OR REPLACE FUNCTION balance_cliente(integer, timestamp) RETURNS numeric AS $$
DECLARE
 resultado numeric;
 rec_cliente RECORD;
 cur_cliente CURSOR(cliente_id integer, fecha timestamp) 
 FOR SELECT 
 FROM film
 WHERE release_year = p_year;
BEGIN
 resultado := (numero1 * numero2) + 100;

 RETURN resultado;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION get_film_titles(p_year INTEGER)
   RETURNS text AS $$
DECLARE 
 titles TEXT DEFAULT '';
 rec_film   RECORD;
 cur_films CURSOR(p_year INTEGER) 
 FOR SELECT 
 FROM film
 WHERE release_year = p_year;
BEGIN
   -- Open the cursor
   OPEN cur_films(p_year);
 
   LOOP
    -- fetch row into the film
      FETCH cur_films INTO rec_film;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;
 
    -- build the output
      IF rec_film.title LIKE '%ful%' THEN 
         titles := titles || ',' || rec_film.title || ':' || rec_film.release_year;
      END IF;
   END LOOP;
  
   -- Close the cursor
   CLOSE cur_films;
 
   RETURN titles;
END; $$
 
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION balance_clientes(timestamp) RETURNS numeric AS $$
DECLARE
 id_cliente ALIAS FOR $1;
 fecha ALIAS FOR $2;
 resultado numeric;
BEGIN
 resultado := (numero1 * numero2) + 100;

 RETURN resultado;
END;
$$ LANGUAGE plpgsql;