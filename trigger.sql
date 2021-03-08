--Universidad Laica Eloy Alfaro de Manabí
--Mendoza Parraga Andres Gonzalo
--Materia: Gestión de base de datos
--Docente y colaborador: Ing. Robert Wilfrido Moreira Centeno, Mg

--Trigger
create or replace function tg_facturapormes() returns trigger
as
$tg_facturapormes$
	declare
		fechafactura date;
begin
		select fecha_autorizacion into fechafactura from factura where id_lectura_medidor=new.id_lectura_medidor;
		if('1/10/2020'<=fechafactura and fechafactura<='31/10/2020') then
			raise exception 'Ya se facturo el medidor ingresado para este mes';
		end if;
		return new;
end;
$tg_facturapormes$
language plpgsql;

create trigger tg_facturapormes before insert
on factura for each row
execute procedure tg_facturapormes();