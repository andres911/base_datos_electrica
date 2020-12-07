--Universidad Laica Eloy Alfaro de Manabí
--Mendoza Parraga Andres Gonzalo
--Materia: Gestión de base de datos
--Docente y colaborador: Ing. Robert Wilfrido Moreira Centeno, Mg

/*==============================================================*/
/* Table: ARREGLA                                               */
/*==============================================================*/
create table ARREGLA (
   CODIGO_INSPECTOR     NUMERIC(8)           not null,
   ID_MEDIDOR           NUMERIC(8)           not null,
   VISTO                NUMERIC              null,
   constraint PK_ARREGLA primary key (CODIGO_INSPECTOR, ID_MEDIDOR)
);

/*==============================================================*/
/* Table: CLIENTE_FACTURA                                       */
/*==============================================================*/
create table CLIENTE_FACTURA (
   ID_CLIENTE           NUMERIC(8)           not null,
   NOMBRE_CLIENTE       CHAR(256)            null,
   APELLIDO_CLIENTE     CHAR(256)            null,
   PROVINCIA_CLIENTE    CHAR(256)            null,
   CANTON_CLIENTE       CHAR(256)            null,
   PARROQUIA_CLIENTE    CHAR(256)            null,
   constraint PK_CLIENTE_FACTURA primary key (ID_CLIENTE)
);

/*==============================================================*/
/* Table: FACTURA                                               */
/*==============================================================*/
create table FACTURA (
   ID_FACTURA           NUMERIC(8)           not null,
   ID_TARIFA            NUMERIC(8)           null,
   ID_CLIENTE           NUMERIC(8)           null,
   ID_LECTURA_MEDIDOR   NUMERIC(8)           null,
   ID_CLIENTE_FACTURA   NUMERIC(8)           null,
   ID_LECTURA_MEDIDOR_FACTURA NUMERIC(8)           null,
   ID_TARIFA_FACTURA    NUMERIC(8)           null,
   FECHA_AUTORIZACION   DATE                 null,
   NUMERO_AUTORIZACION  NUMERIC(8)           null,
   constraint PK_FACTURA primary key (ID_FACTURA)
);

/*==============================================================*/
/* Table: INSPECTOR                                             */
/*==============================================================*/
create table INSPECTOR (
   CODIGO_INSPECTOR     NUMERIC(8)           not null,
   APELLIDO_INSPECTOR   CHAR(256)            null,
   NOMBRE_INSPECTOR     CHAR(256)            null,
   CANTON_INSPECTOR     CHAR(256)            null,
   PARROQUIA_INSPECTOR  CHAR(256)            null,
   constraint PK_INSPECTOR primary key (CODIGO_INSPECTOR)
);

/*==============================================================*/
/* Table: LECTURA_MEDIDOR                                       */
/*==============================================================*/
create table LECTURA_MEDIDOR (
   ID_LECTURA_MEDIDOR   NUMERIC(8)           not null,
   ID_MEDIDOR           NUMERIC(8)           null,
   LECTURA_DESCRIPCION_MEDIDOR CHAR(256)            null,
   LECTURA_ACTUAL       NUMERIC              null,
   LECTURA_ANTERIOR     NUMERIC              null,
   LECTURA_CONSUMO      NUMERIC              null,
   constraint PK_LECTURA_MEDIDOR primary key (ID_LECTURA_MEDIDOR)
);

/*==============================================================*/
/* Table: MEDIDOR                                               */
/*==============================================================*/
create table MEDIDOR (
   ID_MEDIDOR           NUMERIC(8)           not null,
   ID_CLIENTE           NUMERIC(8)           null,
   FECHA_DESDE          DATE                 null,
   FECHA_HASTA          DATE                 null,
   DIAS_FACTURADOS      NUMERIC              null,
   DIRECCION_MEDIDOR    CHAR(256)            null,
   ID_CLIENTE_MEDIDOR   NUMERIC(8)           null,
   ID_LECTURA           NUMERIC(8)           null,
   constraint PK_MEDIDOR primary key (ID_MEDIDOR)
);

/*==============================================================*/
/* Table: TARIFA                                                */
/*==============================================================*/
create table TARIFA (
   ID_TARIFA            NUMERIC(8)           not null,
   NOMBRE_TARIFA        CHAR(256)            null,
   constraint PK_TARIFA primary key (ID_TARIFA)
);

alter table ARREGLA
   add constraint FK_ARREGLA_ARREGLA_INSPECTO foreign key (CODIGO_INSPECTOR)
      references INSPECTOR (CODIGO_INSPECTOR)
      on delete restrict on update restrict;

alter table ARREGLA
   add constraint FK_ARREGLA_ARREGLA2_MEDIDOR foreign key (ID_MEDIDOR)
      references MEDIDOR (ID_MEDIDOR)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_ADQUIERE_CLIENTE_ foreign key (ID_CLIENTE)
      references CLIENTE_FACTURA (ID_CLIENTE)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_POSEE_LECTURA_ foreign key (ID_LECTURA_MEDIDOR)
      references LECTURA_MEDIDOR (ID_LECTURA_MEDIDOR)
      on delete restrict on update restrict;

alter table FACTURA
   add constraint FK_FACTURA_TIENE_TARIFA foreign key (ID_TARIFA)
      references TARIFA (ID_TARIFA)
      on delete restrict on update restrict;

alter table LECTURA_MEDIDOR
   add constraint FK_LECTURA__GENERA_MEDIDOR foreign key (ID_MEDIDOR)
      references MEDIDOR (ID_MEDIDOR)
      on delete restrict on update restrict;

alter table MEDIDOR
   add constraint FK_MEDIDOR_DISPONE_CLIENTE_ foreign key (ID_CLIENTE)
      references CLIENTE_FACTURA (ID_CLIENTE)
      on delete restrict on update restrict;
	  
insert into CLIENTE_FACTURA values (00000001, 'JUAN CARLOS', 'CEDEÑO PILOSO', 'MANABI', 'ROCAFUERTE', 'ROCAFUERTE');
insert into CLIENTE_FACTURA values (00000002, 'JOSUE RICARDO', 'CEDEÑO PILOSO', 'MANABI', 'ROCAFUERTE', 'ROCAFUERTE');
insert into CLIENTE_FACTURA values (00000003,'ANDREINA CRISTINA', 'MENDOZA RIVERA', 'MANABI', 'ROCAFUERTE', 'ROCAFUERTE');

insert into TARIFA values (00000001, 'RESIDENCIAL');
insert into TARIFA values (00000002,'COMERCIAL');
insert into TARIFA values (00000003, 'INDUSTRIAL');
insert into TARIFA values (00000004, 'DISCAPACIDAD');

insert into MEDIDOR values (12345678, 00000002, '9/10/2020', '9/11/2020', 31, 'CALLE PEDRO CARBO', 00000002, 12340000);
insert into MEDIDOR values (86745123, 00000002, '9/10/2020', '9/11/2020', 31, 'CALLE 30 DE SEPTIEMBRE', 00000002, 12350000);
insert into MEDIDOR values (12341234, 00000001, '9/10/2020', '9/11/2020', 31, 'CALLE INDEPENDECIA', 00000001, 34340000);
insert into MEDIDOR values (56781234, 00000003, '9/10/2020', '9/11/2020', 31, 'AV. 6 DE DICIEMBRE', 00000003, 44440000);

insert into LECTURA_MEDIDOR values (12340000, 12345678, 'ENERGIA MEDIDA', 11125, 10794, 331);
insert into LECTURA_MEDIDOR values (12350000, 86745123, 'ENERGIA MEDIDA', 10903, 10235, 668);
insert into LECTURA_MEDIDOR values (34340000, 12341234, 'ENERGIA MEDIDA', 12045, 11345, 700);
insert into LECTURA_MEDIDOR values (44440000, 56781234, 'ENERGIA MEDIDA', 13078, 10756, 2322);

insert into FACTURA values (11112222, 00000001, 00000002, 12340000, 00000002, 12340000, 00000001, '20/10/2020', 12561256);
insert into FACTURA values (11113333, 00000002, 00000002, 12350000, 00000002, 12350000, 00000002, '27/10/2020', 11111256);
insert into FACTURA values (11114444, 00000001, 00000001, 34340000, 00000001, 34340000, 00000001, '22/10/2020', 22221256);
insert into FACTURA values (11115555, 00000001, 00000003, 44440000, 00000003, 44440000, 00000001, '23/10/2020', 33331256);

insert into INSPECTOR values (00000100, 'ZAMBRANO CEDEÑO', 'ALEX CARLOS', 'ROCAFUERTE', 'ROCAFUERTE');
insert into INSPECTOR values (00000101, 'ESPINALES ACOSTA', 'MARTIN JEAN', 'ROCAFUERTE', 'ROCAFUERTE');
insert into INSPECTOR values (00000102, 'MENDOZA BURGOS', 'JAIME ANDRES', 'ROCAFUERTE', 'ROCAFUERTE');
insert into INSPECTOR values (00000103, 'OZAETA PARRAGA', 'GABRIEL ALEX', 'ROCAFUERTE', 'ROCAFUERTE');

insert into ARREGLA values (00000100, 86745123, 1);
insert into ARREGLA values (00000103, 86745123, 1);
insert into ARREGLA values (00000103, 12341234, 1);
insert into ARREGLA values (00000102, 86745123, 1);
insert into ARREGLA values (00000103, 12345678, 1);
insert into ARREGLA values (00000103, 56781234, 1);
insert into ARREGLA values (00000101, 12341234, 1);

--CONSULTA 1
/*select 
	CLIENTE_FACTURA.ID_CLIENTE AS CODIGO_CLIENTE,
	CLIENTE_FACTURA.APELLIDO_CLIENTE AS APELLIDO,
	CLIENTE_FACTURA.NOMBRE_CLIENTE AS NOMBRES,
	CLIENTE_FACTURA.PROVINCIA_CLIENTE AS PROVINCIA,
	CLIENTE_FACTURA.CANTON_CLIENTE AS CANTON,
	CLIENTE_FACTURA.PARROQUIA_CLIENTE AS PARROQUIA,
	MEDIDOR.ID_MEDIDOR AS CODIGO_MEDIDOR,
	MEDIDOR.DIRECCION_MEDIDOR
from CLIENTE_FACTURA
INNER JOIN PUBLIC.MEDIDOR ON MEDIDOR.ID_CLIENTE_MEDIDOR = CLIENTE_FACTURA.ID_CLIENTE
WHERE CLIENTE_FACTURA.APELLIDO_CLIENTE = 'CEDEÑO PILOSO';*/

--CONSULTA 2
/*select
	avg(LECTURA_MEDIDOR.LECTURA_CONSUMO) AS PROMEDIO_CONSUMO_KWH
from LECTURA_MEDIDOR;*/

--CONSULTA 3
/*select
	ARREGLA.CODIGO_INSPECTOR,
	SUM(ARREGLA.VISTO) AS CANTIDAD_INSPECCIONADA,
	INSPECTOR.APELLIDO_INSPECTOR,
	INSPECTOR.NOMBRE_INSPECTOR
FROM ARREGLA
INNER JOIN PUBLIC.INSPECTOR ON INSPECTOR.CODIGO_INSPECTOR = ARREGLA.CODIGO_INSPECTOR
GROUP BY ARREGLA.CODIGO_INSPECTOR, INSPECTOR.NOMBRE_INSPECTOR, INSPECTOR.APELLIDO_INSPECTOR;

select
	ARREGLA.CODIGO_INSPECTOR,
	INSPECTOR.APELLIDO_INSPECTOR,
	INSPECTOR.NOMBRE_INSPECTOR,
	MEDIDOR.ID_MEDIDOR,
	MEDIDOR.DIRECCION_MEDIDOR
FROM ARREGLA
INNER JOIN PUBLIC.INSPECTOR ON INSPECTOR.CODIGO_INSPECTOR = ARREGLA.CODIGO_INSPECTOR
INNER JOIN PUBLIC.MEDIDOR ON MEDIDOR.ID_MEDIDOR = ARREGLA.ID_MEDIDOR;*/

--CONSULTA 4
/*select
	CLIENTE_FACTURA.ID_CLIENTE,
	CLIENTE_FACTURA.NOMBRE_CLIENTE,
	CLIENTE_FACTURA.APELLIDO_CLIENTE,
	MEDIDOR.ID_MEDIDOR,
	MEDIDOR.DIRECCION_MEDIDOR,
	SUM(ARREGLA.VISTO) AS CANTIDAD_INSPECCIONADA
FROM MEDIDOR
INNER JOIN PUBLIC.ARREGLA ON ARREGLA.ID_MEDIDOR = MEDIDOR.ID_MEDIDOR
INNER JOIN PUBLIC.CLIENTE_FACTURA ON CLIENTE_FACTURA.ID_CLIENTE = MEDIDOR.ID_CLIENTE_MEDIDOR 
GROUP BY ARREGLA.ID_MEDIDOR, 
		MEDIDOR.ID_MEDIDOR, 
		MEDIDOR.DIRECCION_MEDIDOR, 
		CLIENTE_FACTURA.ID_CLIENTE, 
		CLIENTE_FACTURA.NOMBRE_CLIENTE,
		CLIENTE_FACTURA.APELLIDO_CLIENTE;*/

--CONSULTA ADICIONAL
/*select
	avg(LECTURA_MEDIDOR.LECTURA_CONSUMO) AS PROMEDIO_CONSUMO_KWH
from LECTURA_MEDIDOR
INNER JOIN PUBLIC.MEDIDOR ON MEDIDOR.ID_MEDIDOR = LECTURA_MEDIDOR.ID_MEDIDOR
WHERE MEDIDOR.DIRECCION_MEDIDOR = 'CALLE INDEPENDECIA' OR MEDIDOR.DIRECCION_MEDIDOR = 'AV. 6 DE DICIEMBRE';*/