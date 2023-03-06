
create sequence location_Id_seq as int start with 100;

create or replace procedure AddNewLocation (
location_name varchar(60),
region varchar(60),
str_name varchar(60), 
building_no varchar(10),
ap_no varchar(10)
)
language plpgsql    
as $$
	
begin
			
	insert into locations (id, location_name, region, street_name, building_no, apartment_no)
	values (nextval('location_Id_seq'), initcap(location_name), initcap(region), initcap(str_name), building_no, ap_no);

    commit;
end;$$


create or replace procedure UpdateLocationName (
old_name varchar(60),
new_name varchar(60)
)
language plpgsql    
as $$
begin
    update locations set location_name = initcap(new_name) 
    	where location_name = initcap(old_name);

    commit;
end;$$

--call UpdateLocationName('old, 'new');  


create sequence people_Id_seq as int start with 10;

create or replace function AddNewPerson(
first_name varchar(60),
last_name varchar(60),
date_of_birth date, 
idnp char(13),
gender varchar(10),
mother_id int default null,
father_id int default null,
location_id int default null
) 
returns integer as $$

declare 
	cid int;
begin
	insert into peoples (id, first_name, last_name, date_of_birth, idnp, gender, mother_id, father_id, location_id, created_on)
	values (nextval('people_Id_seq'), initcap(first_name), initcap(last_name), date_of_birth, idnp, gender, mother_id, father_id, location_id, current_date) 
		returning id into cid;
end;
$$ language plpgsql;
	
select AddNewPerson('First10', 'Last10','2020-02-03', '6754327897654', 'male', 2, 1);


create or replace function UpdatePersonDetails(
personid int,
locationid int 
) 
returns void as $$
	update peoples
	set location_id = locationid 
	where id = personid
$$ language sql;
	
select UpdatePersonDetails(3, 4);































