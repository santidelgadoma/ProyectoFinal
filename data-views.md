
```sql
-- Notamos que, debido a los datos que ingresamos,  varios ejercicios nos regresan tasas 
--mayores a 100. Para un anÃ¡lisis con datos reales, las tasas van a estÃ¡r en (0,100)

-- Todos los views del 1-19 se pueden agrupar tambiÃ©n por wave utilizando el cÃ³digo extract 
-- que se implementa a partir del view nÃºmero 20. 

-- 1) ||View para desplegar las muertes por paÃ­s||
create view MuertesTotales1 as 
	select h.pais_2 as "Pais", sum(mc.muertes_18) as "Muertes Totales" from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.muertes_18 not in (0,-1)
	group by h.pais_2 order by "Muertes Totales" desc;

select * from MuertesTotales1;

-- 2) ||View para desplegar los casos por paÃ­s||
create view CasosTotales as 
	select h.pais_2 as "Pais", sum(mc.casos_pos_15) as "Casos Totales" from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital) 
	where mc.casos_pos_15 not in (0,1)
	group by h.pais_2 order by "Casos Totales" desc;

select * from CasosTotales;

-- 3) ||View para desplegar la tasa de recuperaciÃ³n por paÃ­s||
create view TasaRecuperacion as 
	select h.pais_2 as "Pais", (sum(mc.recuperados_19)::decimal/sum(mc.casos_pos_15)::decimal)*100
	as "Tasa de recuperaciÃ³n" 
	from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.casos_pos_15 not in (0,-1) and mc.recuperados_19!=(-1)
	group by h.pais_2 order by "Tasa de recuperaciÃ³n" asc;

select * from TasaRecuperacion;

-- 4) ||View para desplegar la tasa de mortalidad por paÃ­s||
create view TasaMortalidad as 
	select h.pais_2 as "Pais", (sum(mc.muertes_18)::decimal/sum(mc.casos_pos_15)::decimal)*100
	as "Tasa de mortalidad" 
	from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.casos_pos_15 not in (0,-1) and mc.muertes_18!=(-1)
	group by h.pais_2 order by "Tasa de mortalidad" desc;

select * from TasaMortalidad;


-- 5) ||View para desplegar los hospitales con las situaciones mÃ¡s crÃ­ticas||
create view SituacionCritica1 as 
	select h.nombre_1 as "Nombre del hospital", 
	h.pais_2 as "PaÃ­s en que se encuentra", h.contprin_6 as "Contacto Principal"
	from resources r join monitoreo m on (r.id_monitoreo=m.id_monitoreo) 
	join hospital h on (m.id_hospital=h.id_hospital)
	where r.anestesias_24='1 to 3 days' and r.antypireptico_23='1 to 3 days'
	and r.oxigeno_22='1 to 3 days';

select * from SituacionCritica1;

-- 6) ||Views para desplegar los hospitales con al menos 1 recurso limitado (menos de dos semanas en stock)||
create view RecursosLimitados as 
	select h.nombre_1 as "Nombre del hospital", 
	h.pais_2 as "PaÃ­s en que se encuentra", h.contprin_6 as "Contacto Principal"
	from resources r join monitoreo m on (r.id_monitoreo=m.id_monitoreo) 
	join hospital h on (m.id_hospital=h.id_hospital)
	where r.anestesias_24 in ('1 to 3 days', '4 to 15 days')
	or r.antypireptico_23 in ('1 to 3 days','4 - 15 days')
	or r.oxigeno_22 in ('1 to 3 days','4 - 15 days')
	or r.sol_alcohol_25 in ('1 to 3 days','4 - 15 days')
	or r.cubrebocas_26 in('1 to 3 days', '4 to 15 days')
	or r.guantes_27 in ('1 to 3 days', '4 to 15 days')
	or r.cofias_28 in ('1 to 3 days', '4 to 15 days')
	or r.trajes_doctor_29 in ('1 to 3 days', '4 to 15 days')
	or r.visores_30 in ('1 to 3 days', '4 to 15 days')
	or r.cubre_zapatos_31 in ('1 to 3 days', '4 to 15 days');

select * from RecursosLimitados;

-- 7) || View para desplegar los paÃ­ses ordenados por la cantidad de pacientes covid por doctor||
create view PacientesPorDoctor as 
	select h.pais_2 as "Pais", (sum(mc.casos_pos_15)::decimal/sum(mi.num_doctor_32)::decimal) 
	as "NÃºmero de pacientes por doctor (nacional)" from monitoreo_informacion mi 
	join monitoreo_covid mc on (mi.id_monitoreo=mc.id_monitoreo)
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mi.num_doctor_32 !=0 and mc.casos_pos_15!=(-1)
	group by h.pais_2 order by "NÃºmero de pacientes por doctor (nacional)" desc;

select * from PacientesPorDoctor;

-- 8) ||PaÃ­ses que menos apoyo gubernamental brindan (entre los paÃ­ses que han brindado apoyos)||
create view ApoyoGubernamental as
	select h.pais_2 as "PaÃ­s", count(*) "Apoyos brindados por el gobierno"
	from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.apoyo_21='Yes, from the government'
	group by h.pais_2 
	order by "Apoyos brindados por el gobierno" asc;

select * from ApoyoGubernamental;

-- 9) ||Hospitales que requieren voluntarios (tienen mÃ¡s de 2 pacientes por doctor+paramÃ©dico)||
create view VoluntariosRequeridos as 
	select h.nombre_1 as "Nombre del hospital",h.pais_2 as "PaÃ­s en que se encuentra",
	h.contprin_6 as "NÃºmero de contacto"
	from hospital h join monitoreo m on (h.id_hospital=m.id_hospital)
	join monitoreo_informacion mi on (m.id_monitoreo=mi.id_monitoreo)
	join monitoreo_covid mc on (mi.id_monitoreo=mc.id_monitoreo)
	where mc.casos_pos_15 not in (0,-1) and
	((mi.num_doctor_32)+(mi.num_paramedicos_33))::decimal/(mc.casos_pos_15)::decimal<0.5;

select * from VoluntariosRequeridos;

-- 10) || PaÃ­ses que mÃ¡s campaÃ±as de informaciÃ³n realizan||
create view InfoDifundida as 
	select h.pais_2 "PaÃ­s", count(*) as "CampaÃ±as de informaciÃ³n" 
	from hospital h join monitoreo m on (h.id_hospital=m.id_hospital)
	join monitoreo_covid mc on (m.id_monitoreo=mc.id_monitoreo)
	where mc.info_14 =true
	group by "PaÃ­s" order by "CampaÃ±as de informaciÃ³n" desc;

select * from InfoDifundida;

-- 11) || Hospitales con mayor tasa de resultados positivos de prueba COVID||
create view TasaPositivosHospital as 
	select h.id_hospital ,h.nombre_1 as "Nombre del hospital", h.pais_2 as "PaÃ­s", h.contprin_6 "Contacto",
	(sum(mc.casos_pos_15)::decimal/sum(mc.pruebas_usadas_14))*100 as "Tasa de casos positivos"
	from monitoreo_covid mc join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital) where mc.pruebas_usadas_14 
	not in (0,-1) and mc.casos_pos_15!=(-1)
	group by h.id_hospital order by "Tasa de casos positivos" desc;

select * from TasaPositivosHospital;

-- 12) || PaÃ­ses con mayor tasa de resultados positivos de prueba COVID||
create view TasaPositivosPais as 
	select h.pais_2 as "PaÃ­s", (sum(mc.casos_pos_15)::decimal/sum(mc.pruebas_usadas_14))*100
	as "Tasa de casos positivos" from monitoreo_covid mc join monitoreo m 
	on (mc.id_monitoreo=m.id_monitoreo) join hospital h on (m.id_hospital=h.id_hospital) 
	where mc.pruebas_usadas_14 not in (0,-1) and mc.casos_pos_15!=(-1)
	group by "PaÃ­s" order by "Tasa de casos positivos" desc;

select * from TasaPositivosPais;

-- 13) || Hospitales que presentan algÃºn problema con la encuesta||
create view ProblemasDeEncuesta as
	select h.nombre_1 as "Nombre", h.pais_2 as "PaÃ­s", h.contprin_6 as "Contacto",
	mi.estatus_34 as "Estatus de la encuesta", mi.problemas_35 as "Problemas con la encuesta", 
	mi.accion_36 as "AcciÃ³n requerida" from monitoreo_informacion mi join monitoreo m 
	on (mi.id_monitoreo=m.id_monitoreo) join hospital h on (m.id_hospital=h.id_hospital) 
	where mi.estatus_34!='Questionnaire fully completed' or mi.problemas_35!='No problems'
	or mi.accion_36!='No action needed';

select * from ProblemasDeEncuesta;

-- 14) || PaÃ­ses mÃ¡s problemÃ¡ticos para el encuestamiento||
create view ErroresPorPais as 
	select h.pais_2 as "PaÃ­s", count(*) as "Problemas de encuestamiento" 
	from monitoreo_informacion mi join monitoreo m on (mi.id_monitoreo=m.id_monitoreo) 
	join hospital h on (m.id_hospital=h.id_hospital) 
	where mi.estatus_34!='Questionnaire fully completed' or mi.problemas_35!='No problems'
	or mi.accion_36!='No action needed' group by "PaÃ­s" order by 
	"Problemas de encuestamiento" desc;

select * from ErroresPorPais;

-- 15) || Tasa de mortalidad de los casos graves por paÃ­s||
create view MortCasosGraves as 
	select h.pais_2 as "Pais", (sum(mc.muertes_18)::decimal/sum(mc.casos_graves_17)::decimal)*100
	as "Tasa de mortalidad de los casos graves" 
	from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.muertes_18!=(-1) and mc.casos_graves_17 not in (0,-1)
	group by h.pais_2 order by "Tasa de mortalidad de los casos graves" desc;

select * from MortCasosGraves;

-- 16) || Tasa de recuperaciÃ³n de los casos graves por paÃ­s||
create view RecCasosGraves as 
	select h.pais_2 as "Pais", (sum(mc.recuperados_19)::decimal/sum(mc.casos_graves_17)::decimal)*100
	as "Tasa de recuperaciÃ³n de los casos graves" 
	from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.recuperados_19 !=(-1) and mc.casos_graves_17 not in (0,-1)
	group by h.pais_2 order by "Tasa de recuperaciÃ³n de los casos graves" asc;

select * from RecCasosGraves;

-- 17) || Tasa de casos positivos por caso sospechoso por hospital||
create view TasaPosSospechoso as	
	select h.id_hospital, h.nombre_1 as "Hospital", h.pais_2 as "Pais",
	(sum(mc.casos_pos_15)::decimal/sum(mc.casos_sospech_13)::decimal)*100
	as "Tasa de casos positivos por caso sospechoso" 
	from monitoreo_covid mc 
	join monitoreo m on (mc.id_monitoreo=m.id_monitoreo)
	join hospital h on (m.id_hospital=h.id_hospital)
	where mc.casos_pos_15 !=(-1) and mc.casos_sospech_13 not in (0,-1)
	group by h.id_hospital order by "Tasa de casos positivos por caso sospechoso" desc;

select * from TasaPosSospechoso;

-- 18) || CuÃ¡ntos hospitales tienen protocolos COVID por paÃ­s||
create view ProtocolosPorPais as 
	select h.pais_2 "PaÃ­s", count(*) as "Hospitales con Protocolo COVID" 
	from hospital h join monitoreo m on (h.id_hospital=m.id_hospital)
	join monitoreo_covid mc on (m.id_monitoreo=mc.id_monitoreo)
	where mc.protocolo_12 =true
	group by "PaÃ­s" order by "Hospitales con Protocolo COVID" desc;

select * from ProtocolosPorPais;

-- 19) || Vista auxiliar (para sacar tasas con otros views): Hospitales por paÃ­s||
create view HospitalesPorPais as 
	select h.pais_2 as "Pais", count(*) as "NÃºmero de hospitales" from hospital h 
	group by h.pais_2 order by h.pais_2 asc;

select * from HospitalesPorPais;

-- Los views de needs reflejan cuantos hospitales en (pais, provincia) tiene solamente 
-- 1-3 dÃ­as de stock del recurso en cuestiÃ³n. Pueden hacerse queries anÃ¡logos para cualquier 
-- otro de los recursos. 

-- 20) || Country level needs de anestesia (anÃ¡logo para cualquier otro recurso)||
create view CountryLevelNeeds as
	SELECT EXTRACT ('Month' FROM m.fecha):: varchar ||'/ ' ||  EXTRACT ('Year' FROM m.fecha)::varchar AS wave,
	h.pais_2 ,count (r.anestesias_24='1 to 3 days')
	FROM monitoreo m JOIN hospital h USING (id_hospital) JOIN resources r using(id_monitoreo)
	GROUP BY wave , h.pais_2 ;

select * from CountryLevelNeeds;

-- 21) || Province level needs de anestesia (anÃ¡logo para cualquier recurso)||
create view ProvinceLevelNeeds as 
	SELECT EXTRACT ('Month' FROM m.fecha):: varchar ||'/ ' ||  EXTRACT ('Year' FROM m.fecha)::varchar AS wave,
	h.provin_3 ,count(r.anestesias_24='1 to 3 days')
	FROM monitoreo m JOIN hospital h USING (id_hospital) JOIN resources r using(id_monitoreo)
	GROUP BY wave , h.provin_3 ;

select * from ProvinceLevelNeeds;

-- 22) ||Hospital level needs de anestesia (anÃ¡logos para cualquier recurso)||
-- este view nos indica quÃ© hospitales estÃ¡n en situaciÃ³n crÃ­tica para el recurso especificado. 
-- Anteriormente se realizÃ³ un view en que se considera una situaciÃ³n crÃ­tica extrema en la que 
-- los tres recursos principales estÃ¡n en situaciÃ³n crÃ­tica. 

create view HospitalLevelNeeds as 
	SELECT EXTRACT ('Month' FROM m.fecha):: varchar ||'/ ' ||  EXTRACT ('Year' FROM m.fecha)::varchar AS wave,
	h.nombre_1 ,h.pais_2 , h.provin_3 
	FROM monitoreo m JOIN hospital h USING (id_hospital) JOIN resources r using(id_monitoreo)
	where (r.anestesias_24='1 to 3 days')
	GROUP BY wave , h.id_hospital ;

select * from HospitalLevelNeeds;

-- 23) || Screening awareness||
create view ScreeningAwareness as 
	SELECT EXTRACT ('Month' FROM m.fecha):: varchar ||'/ ' ||  EXTRACT ('Year' FROM m.fecha)::varchar AS wave,
	count( protocolo_12=true) as "Hospitales con protocolo",
	count( pruebas_11=true) as "Hospitales con pruebas"
	FROM monitoreo m JOIN monitoreo_covid mc USING (id_monitoreo)
	GROUP BY wave ;

select * from ScreeningAwareness;

-- 24) || Province trends by wave||
create view ProvinceTrends as 
	SELECT EXTRACT ('Month' FROM m.fecha):: varchar ||'/ ' ||  EXTRACT ('Year' FROM m.fecha)::varchar AS wave,
	h.pais_2 ,h.provin_3 ,
	sum(mc.casos_pos_15) as "Casos positivos",sum(mc.muertes_18) as "Muertes", 
	sum(mc.recuperados_19) as "Recuperados"
	FROM monitoreo m JOIN hospital h USING (id_hospital) JOIN monitoreo_covid mc using(id_monitoreo)
	GROUP BY wave , h.pais_2 ,h.provin_3 ;

select * from ProvinceTrends;

-- 25) || Total de hospitales por tipo de apoyo ||
create view vista_hospitales_apoyo as
	select mc.apoyo_21 , count(h.id_hospital) as "Total de hospitales"
	from monitoreo_informacion mi join monitoreo m using (id_monitoreo) 
	join hospital h using (id_hospital) join monitoreo_covid mc using (id_monitoreo)
	group by mc.apoyo_21 order by mc.apoyo_21 asc;

select * from vista_hospitales_apoyo;

-- 26) ||Total de doctores y paramÃ©dicos por paÃ­s||

create view vista_doctores_paramedicos_pais as
	select h.pais_2 as "PaÃ­s",sum(mi.num_doctor_32) as "Total de doctores",sum(mi.num_paramedicos_33) as "Total de paramÃ©dicos"
	from monitoreo_informacion mi join monitoreo m using (id_monitoreo) join hospital h using (id_hospital)
	group by h.pais_2 order by h.pais_2 asc;

select * from vista_doctores_paramedicos_pais;

-- 27) ||Total de doctores y paramÃ©dicos por provincia||

create view vista_doctores_paramedicos_provincia as
	select h.provin_3 as "Provincia",sum(mi.num_doctor_32) as "Total de doctores",sum(mi.num_paramedicos_33) as "Total de paramÃ©dicos"
	from monitoreo_informacion mi join monitoreo m using (id_monitoreo) join hospital h using (id_hospital)
	group by h.provin_3 order by h.provin_3 asc;

select * from vista_doctores_paramedicos_provincia;

-- 28) ||Total de hospitales que tienen pruebas suficientes (en todos los casos sospechosos) por paÃ­s ||

create view vista_hospitales_pruebas_suficientes_pais as
	select h.pais_2 as "PaÃ­s",count(m.id_monitoreo) as "Total de hospitales"
	from monitoreo_informacion mi join monitoreo m using (id_monitoreo) 
	join hospital h using (id_hospital) join monitoreo_covid mc using (id_monitoreo) 
	where mc.pruebas_11=true and mc.casos_sospech_13=mc.pruebas_usadas_14 
	group by h.pais_2 order by h.pais_2 asc;

select * from vista_hospitales_pruebas_suficientes_pais;

```
