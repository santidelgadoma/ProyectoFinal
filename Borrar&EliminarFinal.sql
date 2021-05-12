-- Borrar datos

delete from pais where id_pais=;

delete from hospital where id_hospital=;

delete from monitoreo where id_monitoreo=;

delete from monitoreo_informacion where id_monitoreo=;

delete from monitoreo_covid where id_monitoreo=;

delete from resources where id_monitoreo=;



-- Eliminar objetos

drop table pais;

drop table hospital;

drop table monitoreo_informacion;

drop table monitoreo_covid;

drop table resources;

drop table monitoreo;