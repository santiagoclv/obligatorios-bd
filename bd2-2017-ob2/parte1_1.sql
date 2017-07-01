--CREATE PROCEDURAL LANGUAGE plpgsql;

CREATE TABLE inconsist_tot_pel (
	id_alerta SERIAL,
	id_pelicula integer
);

CREATE OR REPLACE FUNCTION tot_peliculas() RETURNS TRIGGER AS $tot_peliculas$
  DECLARE
  BEGIN
   INSERT INTO inconsist_tot_pel (id_pelicula) VALUES (NEW."idPelicula"); 
   RETURN NEW;
  END;
$tot_peliculas$ LANGUAGE plpgsql;

CREATE TRIGGER tot_peliculas AFTER INSERT 
    ON peliculas FOR EACH ROW 
    EXECUTE PROCEDURE tot_peliculas();

CREATE OR REPLACE FUNCTION tot_peliculas_borrar() RETURNS TRIGGER AS $tot_peliculas_borrar$
  DECLARE
  BEGIN
   DELETE FROM inconsist_tot_pel WHERE NEW."idPelicula" = id_pelicula; 
   RETURN NEW;
  END;
$tot_peliculas_borrar$ LANGUAGE plpgsql;

CREATE TRIGGER tot_peliculas_borrar AFTER INSERT 
    ON "idiomasDePeliculas" FOR EACH ROW 
    EXECUTE PROCEDURE tot_peliculas_borrar();
