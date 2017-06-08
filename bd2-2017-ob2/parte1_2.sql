CREATE TABLE inconsist_r3 (
	id_sucursal integer,
	id_personal integer
);

CREATE OR REPLACE FUNCTION r3_encargados() RETURNS TRIGGER AS $r3_encargados$
  DECLARE
  BEGIN
	IF EXISTS(SELECT * from personal where "idSucursal" = NEW."idSucursal" AND "idPersonal" = NEW."idEncargado" AND activo = true)
	THEN
		RETURN NEW;
	ELSE
		insert into inconsist_r3 (id_sucursal, id_personal) values ( NEW."idSucursal", NEW."idEncargado");
		RAISE NOTICE 'El encargado con id % no existe o no pertenece a la sucursal id %', NEW."idEncargado", NEW."idSucursal";
		RETURN NULL;
	END IF;
  END;
$r3_encargados$ LANGUAGE plpgsql;

CREATE TRIGGER r3_encargados BEFORE INSERT OR UPDATE  
    ON sucursales FOR EACH ROW 
    EXECUTE PROCEDURE r3_encargados();