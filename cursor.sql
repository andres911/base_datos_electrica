--Universidad Laica Eloy Alfaro de Manabí
--Mendoza Parraga Andres Gonzalo
--Materia: Gestión de base de datos
--Docente y colaborador: Ing. Robert Wilfrido Moreira Centeno, Mg

--Cursor
do $$
declare
		cont int = 0;
		num int;
		tabla record;
		
		medidor_inspeccion cursor for select * from inspector, medidor, arregla
		where arregla.codigo_inspector = inspector.codigo_inspector and arregla.id_medidor = medidor.id_medidor and
		inspector.codigo_inspector = 00000103 and direccion_medidor = 'AV. 6 DE DICIEMBRE';
begin
		for num in medidor_inspeccion
		loop
		cont = cont + count(num.codigo_inspector);
		end loop;
open medidor_inspeccion;
fetch medidor_inspeccion into tabla;
Raise notice 'Nombre del inspector: %, Direccion:  %, Cantidad: %', tabla.nombre_inspector, tabla.direccion_medidor, cont;
end $$
language 'plpgsql';