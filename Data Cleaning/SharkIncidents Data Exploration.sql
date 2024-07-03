-- view all
select *
from sharkincidentscleaned;


-- What MONTHS have the highest reported amount of shark incidents?
select month(date) as month, count(*)
from sharkincidentscleaned
group by month(date)
order by count(*) desc;


-- What YEARS (1950 - 2022) have the highest reported amount of shark incidents?
select year(date) as year, count(*)
from sharkincidentscleaned
group by year(date)
order by count(*) desc;


-- What HOURS of the day have the highest reported amount of shark incidents?
select hour(time), count(*)
from sharkincidentscleaned
group by time
order by count(*) desc;


-- what LOCATIONS have the highest reported amount of shark incidents?
select location, count(*)
from sharkincidentscleaned
group by location
order by count(*) desc;


-- What COUNTIES have the highest reported amount of shark incidents?
select county, count(*)
from sharkincidentscleaned
group by county
order by count(*) desc;


-- How severe are INJURIES for reported shark attacks? Fatal, major, minor, or none.
select injury, count(*)
from sharkincidentscleaned
group by injury
order by count(*) desc;

select fatal, count(*)
from sharkincidentscleaned
group by fatal
order by count(*) desc;


-- What WATER ACTIVITIES results in the highest amount of reported shark incidents?
select mode, count(*)
from sharkincidentscleaned
group by mode
order by count(*) desc;


-- What WATER DEPTH do most reported shark incidents occur?
select depth, count(*)
from sharkincidentscleaned
group by depth
order by count(*) desc;

select depth_simplified, count(*)
from sharkincidentscleaned
group by depth_simplified
order by count(*) desc;


-- What shark SPECIES are most likely to be encountered for reported shark incidents?
select species, count(*)
from sharkincidentscleaned
group by species
order by count(*) desc;

select species_simplified, count(*)
from sharkincidentscleaned
group by species_simplified
order by count(*) desc;


-- Which activities are associated with the most severe injuries?
select mode, injury, count(*)
from sharkincidentscleaned
group by mode, injury
order by count(*) desc;


-- Is there a particular hour/day/month when fatal incidents are more likely to occur?
-- hour(time) can be changed to days(time) or month(time) below
select hour(time), count(*)
from sharkincidentscleaned
where injury = 'fatal'
group by hour(time)
order by count(*) desc;


-- Does the moon phase affect the severity of shark incidents?
select `moon phase`, injury, count(*)
from sharkincidentscleaned
group by `moon phase`, injury
order by count(*) desc;


-- Can we predict the likelihood of an incident resulting in a fatality based on the time of day, location, moon phase, and shark species?
select hour(time) as hour, county, location, `moon phase`, species, 
    case 
        when injury = 'fatal' then 1
        else 2
    end as isfatal
from sharkincidentscleaned;


-- Is there a significant difference in injury severity for different activties within specific counties or locations
select county, location, mode, injury, count(*) as incidentcount
from sharkincidentscleaned
group by county, location, mode, injury
order by incidentcount desc;


-- How has the severity of incidents changed over the decades?
select floor(year(date)/10)*10 as decade, injury, count(*) as incidentcount
from sharkincidents1
group by decade, injury
order by decade, incidentcount desc;

 
-- Is there a correlation between moon phase and shark incidents?
select `moon phase`, count(*)
from sharkincidentscleaned
group by `moon phase`
order by count(*) desc;


-- Are certain shark species more common in specific counties or locations?
-- county can be changed to location
select species, county, count(*)
from sharkincidentscleaned
group by species, county
order by count(*) desc;

select species_simplified, county, count(*)
from sharkincidentscleaned
group by species_simplified, county
order by count(*) desc;


-- How does the depth of water affect the severity of the injury?
select depth, injury, count(*)
from sharkincidentscleaned
group by depth, injury
order by count(*) desc;

select depth_simplified, injury, count(*)
from sharkincidentscleaned
group by depth_simplified, injury
order by count(*) desc;


-- How have incidents involving specific shark species trended over the years?
select year(date), species, count(*)
from sharkincidentscleaned
group by year(date), species
order by year(date), count(*) desc;