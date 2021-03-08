--Universidad Laica Eloy Alfaro de Manabí
--Mendoza Parraga Andres Gonzalo
--Materia: Gestión de base de datos
--Docente y colaborador: Ing. Robert Wilfrido Moreira Centeno, Mg

--Procedimiento almacenado
create or replace function consumo_total (numeric, numeric) returns decimal
as
$$
select sum(lectura_medidor.lectura_consumo) from cliente_factura, medidor, lectura_medidor
where
cliente_factura.id_cliente = medidor.id_cliente and medidor.id_medidor = lectura_medidor.id_medidor and
cliente_factura.id_cliente = $1 and medidor.id_medidor = $2
$$
language sql;