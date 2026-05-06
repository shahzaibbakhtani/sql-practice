create database cricket ; 
use cricket;
create table players (  
    ID      INT PRIMARY KEY,
    player_name    VARCHAR(50),
    team_id        INT,
    role           VARCHAR(20),
    total_runs     INT,
    wickets_taken  INT
);
insert into players values 
(1,  'Virat Kohli',      1, 'Batsman',      27000,  0),
(2,  'Rohit Sharma',     1, 'Batsman',      24000,  0),
(3,  'Jasprit Bumrah',   1, 'Bowler',         500, 150),
(4,  'Babar Azam',       2, 'Batsman',      22000,   0),
(5,  'Shaheen Afridi',   2, 'Bowler',         300, 130),
(6,  'Mohammad Rizwan',  2, 'Wicketkeeper', 10000,   0),
(7,  'Steve Smith',      3, 'Batsman',      20000,   0),
(8,  'Pat Cummins',      3, 'Bowler',         800, 200),
(9,  'Kane Williamson',  4, 'Batsman',      18000,   0),
(10, 'Trent Boult',      4, 'Bowler',         400, 180);


create table team (team_id      INT PRIMARY KEY,
    team_name    VARCHAR(50),
    country      VARCHAR(30),
    world_cups   INT,
    coach        VARCHAR(50)
);

insert into team values 
(1, 'India',       'India',       2,  'Gautam Gambhir'),
(2, 'Pakistan',    'Pakistan',    1,  'Gary Kirsten'),
(3, 'Australia',   'Australia',   6,  'Andrew McDonald'),
(4, 'New Zealand', 'New Zealand', 0,  'Gary Stead');

alter table players
rename column player_name to name;
alter table players
rename column total_runs to runs;

select * from players;

alter table players 
rename column wickets_taken to wickets;

select name, runs from (
select name , runs , avg(runs) over() as avg_runs from players)t where runs > avg_runs;


-- select clause subquery ---

select name , runs,
(select avg(runs) from players) as avg_runs,
runs - (select avg(runs) from players) as diff
from players order by runs desc 
;  


select name , wickets,
	(select avg(wickets) from players) as avg_wickets,
	wickets - (select avg(wickets) from players) as diff
	from players order by wickets desc 
	;


select * from team;

-- Joins query --

select * from players as p left join (
select team_id , sum(world_cups)  from team group by team_id)t on p.team_id = t.team_id ; 


select * from players as p
inner join ( select team_id, world_cups from team where world_cups > 1)t on p.team_id = t.team_id;

select * from players as p inner join (
select team_id, world_cups from team where world_cups > 2)t on p.team_id = t.team_id;

-- where query -- 

select * from players where runs > (select avg(runs) from players);

select * from (
select name , runs , avg(runs) over() avg_runs from players)t where runs > avg_runs;

select name , wickets from players 
				where wickets > (select avg(wickets) from players) and 
				team_id in (select team_id from team where world_cups > 1);
 

select * from players where team_id in 
					(select team_id from team where country != "Australia");

select name , runs from players where  runs > all (select runs from players where role = 'bowler');

select name, wickets from players where wickets  > all
			(select wickets from players where role = "batsman") ;
            
select name, runs ,
(select avg(runs) from players) as avg,
runs > (select avg(runs) from players) as above_avg
from players
;

select name , runs from players where runs > (select avg(runs) from players );

select name , team_id from players where team_id in (select team_id from team);

select * from team;

select * from players where runs =
(select max(runs) from players);


select * from players where team_id in (select team_id from team where world_cups  > 1);

select * from players as p inner join (select world_cups, team_id from team where world_cups > 1)t on p.team_id = t.team_id;

select * from players;

select p.name , p.runs from players p where p.runs > (select avg(runs) from players where team_id = p.team_id);
select name , runs from players where runs > all (select runs from players where role = "bowler");

select *  from (
select name , runs,
(select max(runs) from players) as max_runs, 
(select avg(runs) from players) as avg_runs
from players)t
where   runs > avg_runs and runs < max_runs
;


select p.name from players p where name in (select count(name) from players where team_id = p.team_id);

select name , team_id, count(name) over(partition by team_id) player_per_team from players 
join (select team_id from team)t on players.team_id = team.team_id;

select p.*, t.country, count(name) over(partition by p.team_id) as players_per_team from players p join team t on p.team_id = t.team_id;



-- Correlated subquery --- 

select *, 
(select count(*) from players as C where C.team_id = P.team_id) total
from players as P;

select * , 
(select count(*) from players as C where P.team_id = C.team_id) total_per_team
from players as P ;

-- Exists Logic -- 

select * from players p  where exists
(select * from team as C where country = "Pakistan" 
and p.team_id = C.team_id);

select * from players p where not exists 
(select 1 from team t where country  = "India"  -- Not from India--
and p.team_id = t.team_id);


-- Null--


CREATE TABLE stats (
    player_id     INT PRIMARY KEY,
    player_name   VARCHAR(50),
    country       VARCHAR(30),
    batting_avg   DECIMAL(5,2),
    bowling_avg   DECIMAL(5,2),
    matches       INT,
    last_match    DATE,
    coach_name    VARCHAR(50),
    salary        DECIMAL(10,2)
);

alter table stats 
rename column player_name to name;

INSERT INTO stats VALUES
(1,  'Virat Kohli',     'India',       58.50, NULL,  120, '2024-03-15', 'Rahul Dravid',    500000),
(2,  'Rohit Sharma',    'India',       48.60, NULL,  140, '2024-03-15', 'Rahul Dravid',    NULL),
(3,  'Jasprit Bumrah',  'India',       NULL,  21.50,  85,  NULL,        'Rahul Dravid',    NULL),
(4,  'Babar Azam',      'Pakistan',    52.30, NULL,   95, '2024-03-10',  NULL,             450000),
(5,  'Shaheen Afridi',  'Pakistan',    NULL,  18.20,  88, '2024-01-15',  NULL,             300000),
(6,  'Mohammad Rizwan', 'Pakistan',    NULL,  NULL,  102, '2023-12-10',  NULL,             280000),
(7,  'Steve Smith',     'Australia',   61.80, NULL,  130,  NULL,        'Andrew McDonald', 520000),
(8,  'Pat Cummins',     'Australia',   NULL,  20.90,  98, '2024-02-28',  NULL,             510000),
(9,  'Kane Williamson', 'New Zealand', NULL,  NULL,  115, '2024-03-01', 'Gary Stead',      480000),
(10, 'Trent Boult',     'New Zealand', NULL,  22.00,  90, '2024-01-20', 'Gary Stead',      NULL);

select * from stats;

select name , batting_avg, 
coalesce(batting_avg , 0) zero_for_null,
count(batting_avg) over() as count1,
count(coalesce(batting_avg,0)) over() as count2
from stats;

-- For maths and strings--

select name , coach_name,
concat(name , " " , coach_name) as player_coach
from stats;

select name , coach_name , concat(name , ' ' , coalesce(coach_name , "No Coach")) as player_coach from stats;

select name , coach_name , concat(name , ' ' , coalesce(coach_name , "No Coach")) as player_coach,
salary ,coalesce(salary, 0) + 20000 as salarywithbonus
from stats;

-- Sorting Data -- 
select name ,batting_avg,
case when batting_avg is null then 1 else 0 end Flag
from stats order by batting_avg ;

select batting_avg , nullif(batting_avg, null) as NULLIF from stats;



