-- VIEW DATASET
select *
from sharkincidents;


-- CREATE COPY OF DATASET
create table sharkincidents1 (
select *
from sharkincidents
);

select *
from sharkincidents1; -- 192 rows

create table moons1 (
select *
from moons
);

select *
from moons1;


-- CHECK FOR DUPLICATE ROWS
select distinct *
from sharkincidents1; -- 192 rowssharkincidents


-- if duplicates rows were present:
-- 1. create temp table storing distinct query
create temporary table sharkincidents_temp (
	select distinct *
    from sharkincidents1
);

-- 2. remove current existing records within sharkincidents1
delete from sharkincidents1;

-- 3. insert records from temp table (sharkincidents_temp) into blank sharkincidents1
insert into sharkincidents1
select * 
from sharkincidents_temp;
 
-- 4. remove temp table
drop temporary table sharkincidents_temp;


-- STANDARDIZING DATA (removing extra spaces, spelling inconsistancies among identical rows: United States vs US)
-- 1. remove all rows where IncidentNum = 'NOT COUNTED'
delete from sharkincidents1
where incidentnum = 'NOT COUNTED';

-- 2. Under TIME column, decide what to do with 'Unknown' and 'early am'.

select distinct time
from sharkincidents1;

update sharkincidents1 -- decided to update 'early am' to 'unknown' since 'unknown' already exists 15 other times.
set time = 'Unknown'
where time = 'early am';

-- 3. remove * on cells under Injury, Depth, and Species columns
-- to view
select distinct injury 
from sharkincidents1;

select distinct depth
from sharkincidents1;

select distinct species
from sharkincidents1;

-- updating
update sharkincidents1
set injury = replace(injury, '*', '');

update sharkincidents1
set depth = replace(depth, '*', '');

update sharkincidents1
set species = replace(species, '*', '');

-- standardize DEPTH column. 'Unknown' spelled 'Unkown'. 35' needs to be converted to 35 to be consistant w/ format of other measurements. Change N/A to Unknown?
update sharkincidents1
set depth = 'Unknown'
where depth = 'Unkown' or depth = 'N/A';

update sharkincidents1
set depth = replace(depth, '\'', '');


-- extra space in front of 'la jolla, children's pool' under LOCATION column. Note: Location column might not be used in analysis since county exists. Too many inconsistancies w/ names.
select distinct location
from sharkincidents1
order by location;

update sharkincidents1
set location = trim(location)
where location like ' La Jolla, Children\'s Pool';


-- 4. remove Confirmed Source and WFL Case # columns, not needed for analysis
alter table sharkincidents1
drop column `confirmed source`,
drop column `wfl case #`;


-- 5. convert TIME column to time type. Will leave as 24 hour format, can convert to 12 hour format on Tableau. Needing to convert value to NULL where time = 'unknown' first, 'alter table sharkincidents1 modify column time time' not working
update sharkincidents1
set time = null
where time = 'Unknown';

alter table sharkincidents1 modify column time time;

update sharkincidents1
set time = 'Unknown'
where time is NULL;

-- 6. convert DATE column to date type
update sharkincidents1
set date = str_to_date(date, '%m/%d/%Y');

alter table sharkincidents1
modify column date date;

-- 7. Simplifying columns of 1. water depth, 2. shark species, and 3. injury type into specific categories
-- water depth into categories of counts of 10 (surface, 0-10, 11-20, etc.)
-- shark species into categories of White and Other (every other species)
-- injury type into categories of Fatal? =  Yes or No

alter table sharkincidents1
add column `Depth_simplified` varchar(15);

update sharkincidents1
set depth_simplified = case
when depth = 'surface' then 'Surface'
when depth = 'submerged' then 'Submerged'
when depth = 'unknown' then 'Unknown'
when depth between 0 and 10 then '0-10'
when depth between 11 and 20 then '11-20'
when depth between 21 and 30 then '21-30'
when depth between 31 and 40 then '31-40'
when depth > 41 then '41+'
end;


alter table sharkincidents1
add column `Species_simplified` varchar(10);

update sharkincidents1
set species_simplified = case
when species = 'white' then 'White'
else 'Other'
end;


alter table sharkincidents1
add column `Fatal` varchar(3);

update sharkincidents1
set fatal = case
when injury = 'fatal' then 'Yes'
else 'No'
end;


-- left join sharkincidents1 with moons table on incidentnum. 'Moon phase' and 'percent full' from 'moons1' table gets carried over. 
select * from sharkincidents1;
select * from moons1;

-- FINAL
select sharkincidents1.*, moons1.`Moon Phase`, moons1.`Percent Full`
from sharkincidents1
left join moons1
on sharkincidents1.incidentnum = moons1.incidentnum;

create table sharkincidentscleaned (
select sharkincidents1.*, moons1.`Moon Phase`, moons1.`Percent Full`
from sharkincidents1
left join moons1
on sharkincidents1.incidentnum = moons1.incidentnum
);

select *
from sharkincidentscleaned
