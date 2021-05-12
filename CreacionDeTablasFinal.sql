-- Crear tablas


CREATE TABLE pais(
	id_pais varchar NOT NULL,
	CONSTRAINT pk_pais PRIMARY KEY(id_pais)
);

CREATE TABLE hospital (
	id_hospital varchar NOT NULL,
	nombre_1 varchar NOT NULL,
	pais_2 varchar NOT NULL REFERENCES pais(id_pais) ON UPDATE CASCADE ON DELETE CASCADE,
  	provin_3 varchar NOT NULL ,
  	ciudad_4 varchar NOT NULL ,
  	cp_5 varchar NOT NULL,
  	contprin_6 varchar(30) NOT NULL,
  	contaux_7 varchar(30) ,
  	direc_8 varchar NOT NULL ,
  	tipo_9 varchar NOT NULL,
  	registro_10 int NOT NULL,
	UNIQUE(pais_2,registro_10),
	CONSTRAINT pk_hospital PRIMARY KEY (id_hospital)
);


CREATE TABLE monitoreo (
	id_monitoreo serial NOT NULL,
	id_hospital varchar REFERENCES hospital(id_hospital) ON UPDATE CASCADE ON DELETE CASCADE,
	fecha timestamp,
  	CONSTRAINT pk_monitoreo PRIMARY KEY (id_monitoreo)
);

CREATE TABLE monitoreo_informacion (
	id_monitoreo serial NOT NULL REFERENCES monitoreo(id_monitoreo) ON UPDATE CASCADE ON DELETE cascade unique,
	estatus_34 varchar,
	problemas_35 varchar,
	accion_36 varchar,
	num_doctor_32 int,
	num_paramedicos_33 int
);

CREATE TABLE resources (
	id_monitoreo serial NOT NULL REFERENCES monitoreo(id_monitoreo) ON UPDATE CASCADE ON DELETE cascade unique,
	ventiladores_20 varchar,
  	oxigeno_22 varchar,
  	antypireptico_23 varchar,
 	anestesias_24 varchar,
	sol_alcohol_25 varchar,
  	cubrebocas_26 varchar,
  	guantes_27 varchar,
  	cofias_28 varchar,
 	trajes_doctor_29 varchar,
 	visores_30 varchar,
 	cubre_zapatos_31 varchar
);

CREATE TABLE monitoreo_covid(
	id_monitoreo serial NOT NULL REFERENCES monitoreo(id_monitoreo) ON UPDATE CASCADE ON DELETE cascade unique,
	pruebas_11 boolean,
	protocolo_12 boolean,
	info_14 boolean,
	casos_sospech_13 int,
	pruebas_usadas_14 int,
	casos_pos_15 int,
	casos_phc_16 int,
	casos_graves_17 int,
  	muertes_18 int,
  	recuperados_19 int,
  	apoyo_21 boolean
);