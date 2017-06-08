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


INSERT INTO peliculas (titulo, descripcion, anio, "idIdiomaOriginal", "duracionAlquiler", "costoAlquiler", duracion, "costoReemplazo", clasificacion, "contenidosExtra")
 VALUES ('CLONES PINOCCHIO', 'A Amazing Drama of a Car And a Robot who must Pursue a Dentist in New Orleans', 2006, 1, 6, 59.80, 124, 339.80, 'R', '{"Behind the Scenes"}');

select * from inconsist_tot_pel;
id_alerta, id_pelicula
1;1001

INSERT INTO "idiomasDePeliculas" ("idIdioma", "idPelicula") VALUES (1, 1001);
select * from inconsist_tot_pel;
id_alerta, id_pelicula
-;-
