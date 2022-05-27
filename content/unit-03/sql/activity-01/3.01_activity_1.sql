use bank database;

select * from client
inner join district d on d.A1 = d.district_id;