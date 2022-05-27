use bank;

-- 3.02 -1
select * from bank.disp d
join bank.client c
on d.client_id = c.client_id
join bank.district da
on da.A1 = c.district_id
where d.type = "OWNER";

-- 3.02 -2
select * from 
left join 
