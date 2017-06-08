--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.9
-- Dumped by pg_dump version 9.1.9
-- Started on 2013-10-24 00:02:14 UYST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 185 (class 3079 OID 11717)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2073 (class 0 OID 0)
-- Dependencies: 185
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 506 (class 1247 OID 16386)
-- Dependencies: 5
-- Name: mpaa_rating; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE mpaa_rating AS ENUM (
    'G',
    'PG',
    'PG-13',
    'R',
    'NC-17'
);


--
-- TOC entry 509 (class 1247 OID 16397)
-- Dependencies: 510 5
-- Name: year; Type: DOMAIN; Schema: public; Owner: -
--

CREATE DOMAIN year AS integer
	CONSTRAINT year_check CHECK (((VALUE >= 1901) AND (VALUE <= 2155)));


--
-- TOC entry 161 (class 1259 OID 16399)
-- Dependencies: 5
-- Name: actor_actor_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE actor_actor_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


SET default_with_oids = false;

--
-- TOC entry 170 (class 1259 OID 16417)
-- Dependencies: 2002 5
-- Name: actores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE actores (
    "idActor" integer DEFAULT nextval('actor_actor_id_seq'::regclass) NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL
);


--
-- TOC entry 171 (class 1259 OID 16421)
-- Dependencies: 5
-- Name: actoresDePeliculas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "actoresDePeliculas" (
    "idActor" smallint NOT NULL,
    "idPelicula" smallint NOT NULL
);


--
-- TOC entry 172 (class 1259 OID 16424)
-- Dependencies: 5
-- Name: alquileres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE alquileres (
    "idPelicula" smallint NOT NULL,
    "idSucursal" smallint NOT NULL,
    "idCliente" smallint NOT NULL,
    fecha timestamp without time zone NOT NULL,
    "idPersonal" smallint NOT NULL,
    "fechaDevolucion" timestamp without time zone
);


--
-- TOC entry 162 (class 1259 OID 16401)
-- Dependencies: 5
-- Name: categoria_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categoria_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 173 (class 1259 OID 16427)
-- Dependencies: 2003 5
-- Name: categorias; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categorias (
    "idCategoria" integer DEFAULT nextval('categoria_categoria_id_seq'::regclass) NOT NULL,
    categoria character varying(25) NOT NULL
);


--
-- TOC entry 174 (class 1259 OID 16431)
-- Dependencies: 5
-- Name: categoriasDePeliculas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "categoriasDePeliculas" (
    "idPelicula" smallint NOT NULL,
    "idCategoria" smallint NOT NULL
);


--
-- TOC entry 163 (class 1259 OID 16403)
-- Dependencies: 5
-- Name: ciudad_id_ciudad_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ciudad_id_ciudad_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 175 (class 1259 OID 16434)
-- Dependencies: 2004 5
-- Name: ciudades; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ciudades (
    "idCiudad" integer DEFAULT nextval('ciudad_id_ciudad_seq'::regclass) NOT NULL,
    ciudad character varying(50) NOT NULL,
    "idPais" smallint NOT NULL
);


--
-- TOC entry 164 (class 1259 OID 16405)
-- Dependencies: 5
-- Name: cliente_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cliente_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 176 (class 1259 OID 16438)
-- Dependencies: 2005 2006 5
-- Name: clientes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE clientes (
    "idCliente" integer DEFAULT nextval('cliente_cliente_id_seq'::regclass) NOT NULL,
    "idSucursal" smallint NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    email character varying(50),
    direccion character varying(50) NOT NULL,
    "idCiudad" smallint NOT NULL,
    codigo_postal character varying(10),
    telefono character varying(20) NOT NULL,
    activo boolean DEFAULT true NOT NULL
);


--
-- TOC entry 165 (class 1259 OID 16407)
-- Dependencies: 5
-- Name: idioma_id_idioma_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE idioma_id_idioma_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 177 (class 1259 OID 16443)
-- Dependencies: 2007 5
-- Name: idiomas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE idiomas (
    "idIdioma" integer DEFAULT nextval('idioma_id_idioma_seq'::regclass) NOT NULL,
    idioma character(20) NOT NULL
);


--
-- TOC entry 178 (class 1259 OID 16447)
-- Dependencies: 5
-- Name: idiomasDePeliculas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "idiomasDePeliculas" (
    "idIdioma" smallint NOT NULL,
    "idPelicula" smallint NOT NULL
);


--
-- TOC entry 179 (class 1259 OID 16450)
-- Dependencies: 5
-- Name: inventario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inventario (
    "idPelicula" smallint NOT NULL,
    "idSucursal" smallint NOT NULL,
    "cantEjemplares" smallint NOT NULL
);


--
-- TOC entry 180 (class 1259 OID 16453)
-- Dependencies: 5
-- Name: pagos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pagos (
    "idPeliculaAlquilo" smallint NOT NULL,
    "idClienteAlquilo" smallint NOT NULL,
    "idSucursalAlquilo" smallint NOT NULL,
    "idPersonalAlquilo" smallint NOT NULL,
    "fechaAlquilo" timestamp without time zone NOT NULL,
    "idPersonalRecibePago" smallint NOT NULL,
    monto numeric(5,2) NOT NULL,
    fecha timestamp without time zone NOT NULL
);


--
-- TOC entry 166 (class 1259 OID 16409)
-- Dependencies: 5
-- Name: pais_id_pais_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pais_id_pais_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 181 (class 1259 OID 16456)
-- Dependencies: 2008 5
-- Name: paises; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE paises (
    "idPais" integer DEFAULT nextval('pais_id_pais_seq'::regclass) NOT NULL,
    pais character varying(50) NOT NULL
);


--
-- TOC entry 167 (class 1259 OID 16411)
-- Dependencies: 5
-- Name: pelicula_pelicula_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pelicula_pelicula_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 182 (class 1259 OID 16460)
-- Dependencies: 2009 2010 2011 2012 2013 506 509 5
-- Name: peliculas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE peliculas (
    "idPelicula" integer DEFAULT nextval('pelicula_pelicula_id_seq'::regclass) NOT NULL,
    titulo character varying(255) NOT NULL,
    descripcion text,
    anio year,
    "idIdiomaOriginal" smallint,
    "duracionAlquiler" smallint DEFAULT 3 NOT NULL,
    "costoAlquiler" numeric(4,2) DEFAULT 99.8 NOT NULL,
    duracion smallint,
    "costoReemplazo" numeric(5,2) DEFAULT 399.8 NOT NULL,
    clasificacion mpaa_rating DEFAULT 'G'::mpaa_rating,
    "contenidosExtra" text[]
);


--
-- TOC entry 168 (class 1259 OID 16413)
-- Dependencies: 5
-- Name: personal_id_personal_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE personal_id_personal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 183 (class 1259 OID 16471)
-- Dependencies: 2014 2015 5
-- Name: personal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE personal (
    "idPersonal" integer DEFAULT nextval('personal_id_personal_seq'::regclass) NOT NULL,
    nombre character varying(45) NOT NULL,
    apellido character varying(45) NOT NULL,
    direccion character varying(50) NOT NULL,
    "idCiudad" smallint NOT NULL,
    "codigoPostal" character varying(10),
    telefono character varying(20) NOT NULL,
    email character varying(50),
    "idSucursal" smallint NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    usuario character varying(16) NOT NULL,
    password character varying(40)
);


--
-- TOC entry 169 (class 1259 OID 16415)
-- Dependencies: 5
-- Name: sucursal_sucursal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sucursal_sucursal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 184 (class 1259 OID 16476)
-- Dependencies: 2016 5
-- Name: sucursales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sucursales (
    "idSucursal" integer DEFAULT nextval('sucursal_sucursal_id_seq'::regclass) NOT NULL,
    "idEncargado" smallint NOT NULL,
    direccion character varying(50) NOT NULL,
    "idCiudad" smallint NOT NULL,
    "codigoPostal" character varying(10),
    telefono character varying(20) NOT NULL
);


--
-- TOC entry 2020 (class 2606 OID 16481)
-- Dependencies: 171 171 171 2068
-- Name: actor_de_pelicula_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "actoresDePeliculas"
    ADD CONSTRAINT actor_de_pelicula_pkey PRIMARY KEY ("idActor", "idPelicula");


--
-- TOC entry 2018 (class 2606 OID 16483)
-- Dependencies: 170 170 2068
-- Name: actores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY actores
    ADD CONSTRAINT actores_pkey PRIMARY KEY ("idActor");


--
-- TOC entry 2022 (class 2606 OID 16485)
-- Dependencies: 172 172 172 172 172 172 2068
-- Name: alquileres_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY alquileres
    ADD CONSTRAINT alquileres_pkey PRIMARY KEY ("idPelicula", "idCliente", "idSucursal", "idPersonal", fecha);


--
-- TOC entry 2026 (class 2606 OID 16487)
-- Dependencies: 174 174 174 2068
-- Name: categoria_de_pelicula_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "categoriasDePeliculas"
    ADD CONSTRAINT categoria_de_pelicula_pkey PRIMARY KEY ("idPelicula", "idCategoria");


--
-- TOC entry 2024 (class 2606 OID 16489)
-- Dependencies: 173 173 2068
-- Name: categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY ("idCategoria");


--
-- TOC entry 2028 (class 2606 OID 16491)
-- Dependencies: 175 175 2068
-- Name: ciudades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciudades
    ADD CONSTRAINT ciudades_pkey PRIMARY KEY ("idCiudad");


--
-- TOC entry 2030 (class 2606 OID 16493)
-- Dependencies: 176 176 2068
-- Name: clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY ("idCliente");


--
-- TOC entry 2034 (class 2606 OID 16495)
-- Dependencies: 178 178 178 2068
-- Name: idioma_de_pelicula_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "idiomasDePeliculas"
    ADD CONSTRAINT idioma_de_pelicula_pkey PRIMARY KEY ("idIdioma", "idPelicula");


--
-- TOC entry 2032 (class 2606 OID 16497)
-- Dependencies: 177 177 2068
-- Name: idiomas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY idiomas
    ADD CONSTRAINT idiomas_pkey PRIMARY KEY ("idIdioma");


--
-- TOC entry 2036 (class 2606 OID 16499)
-- Dependencies: 179 179 179 2068
-- Name: inventario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_pkey PRIMARY KEY ("idPelicula", "idSucursal");


--
-- TOC entry 2038 (class 2606 OID 16501)
-- Dependencies: 180 180 180 180 180 180 180 2068
-- Name: pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pagos
    ADD CONSTRAINT pagos_pkey PRIMARY KEY ("idPeliculaAlquilo", "idClienteAlquilo", "idSucursalAlquilo", "idPersonalAlquilo", "fechaAlquilo", fecha);


--
-- TOC entry 2040 (class 2606 OID 16503)
-- Dependencies: 181 181 2068
-- Name: paises_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY paises
    ADD CONSTRAINT paises_pkey PRIMARY KEY ("idPais");


--
-- TOC entry 2042 (class 2606 OID 16505)
-- Dependencies: 182 182 2068
-- Name: peliculas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY peliculas
    ADD CONSTRAINT peliculas_pkey PRIMARY KEY ("idPelicula");


--
-- TOC entry 2044 (class 2606 OID 16507)
-- Dependencies: 183 183 2068
-- Name: personal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personal
    ADD CONSTRAINT personal_pkey PRIMARY KEY ("idPersonal");


--
-- TOC entry 2046 (class 2606 OID 16509)
-- Dependencies: 184 184 2068
-- Name: sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sucursales
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY ("idSucursal");


--
-- TOC entry 2047 (class 2606 OID 16619)
-- Dependencies: 2017 171 170 2068
-- Name: actor_de_pelicula_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "actoresDePeliculas"
    ADD CONSTRAINT actor_de_pelicula_actor_id_fkey FOREIGN KEY ("idActor") REFERENCES actores("idActor") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2048 (class 2606 OID 16624)
-- Dependencies: 2041 171 182 2068
-- Name: actor_de_pelicula_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "actoresDePeliculas"
    ADD CONSTRAINT actor_de_pelicula_pelicula_id_fkey FOREIGN KEY ("idPelicula") REFERENCES peliculas("idPelicula") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2061 (class 2606 OID 16520)
-- Dependencies: 172 2021 180 180 180 180 180 172 172 172 172 2068
-- Name: alquiler_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pagos
    ADD CONSTRAINT alquiler_fkey FOREIGN KEY ("idPeliculaAlquilo", "idClienteAlquilo", "idSucursalAlquilo", "idPersonalAlquilo", "fechaAlquilo") REFERENCES alquileres("idPelicula", "idCliente", "idSucursal", "idPersonal", fecha) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2049 (class 2606 OID 16525)
-- Dependencies: 2035 179 179 172 172 2068
-- Name: alquileres_alquiler_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY alquileres
    ADD CONSTRAINT alquileres_alquiler_fkey FOREIGN KEY ("idPelicula", "idSucursal") REFERENCES inventario("idPelicula", "idSucursal") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2050 (class 2606 OID 16530)
-- Dependencies: 2029 172 176 2068
-- Name: alquileres_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY alquileres
    ADD CONSTRAINT alquileres_id_cliente_fkey FOREIGN KEY ("idCliente") REFERENCES clientes("idCliente") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2051 (class 2606 OID 16535)
-- Dependencies: 183 172 2043 2068
-- Name: alquileres_id_personal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY alquileres
    ADD CONSTRAINT alquileres_id_personal_fkey FOREIGN KEY ("idPersonal") REFERENCES personal("idPersonal") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2052 (class 2606 OID 16634)
-- Dependencies: 174 173 2023 2068
-- Name: categoria_de_pelicula_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "categoriasDePeliculas"
    ADD CONSTRAINT categoria_de_pelicula_categoria_id_fkey FOREIGN KEY ("idCategoria") REFERENCES categorias("idCategoria") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2053 (class 2606 OID 16639)
-- Dependencies: 2041 174 182 2068
-- Name: categoria_de_pelicula_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "categoriasDePeliculas"
    ADD CONSTRAINT categoria_de_pelicula_pelicula_id_fkey FOREIGN KEY ("idPelicula") REFERENCES peliculas("idPelicula") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2054 (class 2606 OID 16550)
-- Dependencies: 175 181 2039 2068
-- Name: ciudad_id_pais_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ciudades
    ADD CONSTRAINT ciudad_id_pais_fkey FOREIGN KEY ("idPais") REFERENCES paises("idPais") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2055 (class 2606 OID 16555)
-- Dependencies: 175 176 2027 2068
-- Name: cliente_ciudad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT cliente_ciudad_fkey FOREIGN KEY ("idCiudad") REFERENCES ciudades("idCiudad") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2056 (class 2606 OID 16560)
-- Dependencies: 2045 184 176 2068
-- Name: cliente_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY clientes
    ADD CONSTRAINT cliente_sucursal_fkey FOREIGN KEY ("idSucursal") REFERENCES sucursales("idSucursal") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2057 (class 2606 OID 16644)
-- Dependencies: 178 177 2031 2068
-- Name: idioma_de_pelicula_idioma_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "idiomasDePeliculas"
    ADD CONSTRAINT idioma_de_pelicula_idioma_id_fkey FOREIGN KEY ("idIdioma") REFERENCES idiomas("idIdioma") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2058 (class 2606 OID 16649)
-- Dependencies: 178 182 2041 2068
-- Name: idioma_de_pelicula_pelicula_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "idiomasDePeliculas"
    ADD CONSTRAINT idioma_de_pelicula_pelicula_id_fkey FOREIGN KEY ("idPelicula") REFERENCES peliculas("idPelicula") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2059 (class 2606 OID 16575)
-- Dependencies: 179 182 2041 2068
-- Name: inventario_id_pelicula_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_id_pelicula_fkey FOREIGN KEY ("idPelicula") REFERENCES peliculas("idPelicula") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2060 (class 2606 OID 16580)
-- Dependencies: 184 2045 179 2068
-- Name: inventario_id_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inventario
    ADD CONSTRAINT inventario_id_sucursal_fkey FOREIGN KEY ("idSucursal") REFERENCES sucursales("idSucursal") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2062 (class 2606 OID 16585)
-- Dependencies: 183 180 2043 2068
-- Name: pagos_id_personal_recibe_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pagos
    ADD CONSTRAINT pagos_id_personal_recibe_pago_fkey FOREIGN KEY ("idPersonalRecibePago") REFERENCES personal("idPersonal") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2063 (class 2606 OID 16590)
-- Dependencies: 182 177 2031 2068
-- Name: pelicula_original_id_idioma_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY peliculas
    ADD CONSTRAINT pelicula_original_id_idioma_fkey FOREIGN KEY ("idIdiomaOriginal") REFERENCES idiomas("idIdioma") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2064 (class 2606 OID 16595)
-- Dependencies: 175 183 2027 2068
-- Name: personal_ciudad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personal
    ADD CONSTRAINT personal_ciudad_fkey FOREIGN KEY ("idCiudad") REFERENCES ciudades("idCiudad") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2065 (class 2606 OID 16600)
-- Dependencies: 184 2045 183 2068
-- Name: personal_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY personal
    ADD CONSTRAINT personal_sucursal_fkey FOREIGN KEY ("idSucursal") REFERENCES sucursales("idSucursal") ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 2066 (class 2606 OID 16605)
-- Dependencies: 184 2027 175 2068
-- Name: sucursal_id_diudad_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sucursales
    ADD CONSTRAINT sucursal_id_diudad_fkey FOREIGN KEY ("idCiudad") REFERENCES ciudades("idCiudad") ON UPDATE CASCADE ON DELETE RESTRICT;


-- Completed on 2013-10-24 00:02:15 UYST

--
-- PostgreSQL database dump complete
--

