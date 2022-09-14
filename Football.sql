-- Use this template for your se2222 term project
-- Before submission be sure that your file is named like [your_ID].sql
-- Name:Ayça Bilik
-- ID: 18070006018
-- Short description of your scenario:
-- This scenario about football. Football has players, leagues, squads, staffs, stadiums, referee and fixtures.the players are part of the squad. 
-- Every squad needs sponsors, a president, a coach and a stadium to play in. each squad plays a match in a league. The person who directs the matches is the referee. 
-- Squad get some points from the matches played. These scores are determined depending on some factors. 
-- Elements such as the date and place of the matches and the name of the teams playing are called fixtures.



CREATE SCHEMA SE2222_18070006018;
USE SE2222_18070006018;
-- 1. Definitions:


-- There are leagues where the teams are located. Teams compete for the championship in this league.
CREATE TABLE League(
LeagueName varchar(20),
NumberOfSquad int NOT NULL,

CONSTRAINT leag_leaName_pk PRIMARY KEY (LeagueName)
);

-- The astroturf where the match is held is called the stadium.
CREATE TABLE Stadium(
StadiumName varchar(50),
Seats int NOT NULL,
CONSTRAINT stad_stadName_pk PRIMARY KEY (StadiumName)
);

-- Squad is a football club. Club has a own stadium, players. The more successful the squad, the higher its market value. Squad has a place in table about league.
CREATE TABLE Squad(
SquadName varchar(30) ,
Average_Age double NOT NULL,
LeagueName varchar(20) NOT NULL,     
Size int NOT NULL,
StadiumName varchar(50) NOT NULL,         
Total_market_value int NOT NULL,
Table_position int NOT NULL,

CONSTRAINT squad_squadName_pk PRIMARY KEY (SquadName),
CONSTRAINT squad_leaName_fk FOREIGN KEY (LeagueName) REFERENCES League (LeagueName),
CONSTRAINT squad_stadName_fk FOREIGN KEY (StadiumName) REFERENCES Stadium (StadiumName)
);


-- The league table shows which team in which order. There are some elements for this. For example, goals for, goals against, number of matches won...
CREATE TABLE League_table(
Season varchar(9) NOT NULL, 
LeagueName varchar(20) NOT NULL, 
Table_Position int NOT NULL,
SquadName varchar(30) NOT NULL,
Games_played int NOT NULL,
Wins int NOT NULL,
Draws int NOT NULL,
Losses int NOT NULL,
Goals_for int NOT NULL,
Goals_against int NOT NULL,
Goal_difference int NOT NULL,
Points int NOT NULL,

CONSTRAINT table_squadName_fk  FOREIGN KEY (SquadName) REFERENCES Squad (SquadName),
CONSTRAINT table_LeagueName_fk FOREIGN KEY (LeagueName) REFERENCES League (LeagueName)
);

-- each player has its own license. players have position names based on where they play on the match.
-- Market values are determined according to what they do in the match. For example, Apperances, Yellowcards, Redcards, Totalgoals, Assists.
CREATE TABLE Player(
licenseNumber varchar(5),
playerName VARCHAR(30) NOT NULL,
SquadName varchar(30)  NOT NULL,
jerseyNumber int NOT NULL,
Age int NOT NULL,
Height int NOT NULL,
Country varchar(15),
Marketvalue int NOT NULL,
Apperances int NOT NULL, 
Yellowcards int NOT NULL,
Redcards int NOT NULL,
Totalgoals int NOT NULL,
Assists int NOT NULL,
Player_position varchar(30) NOT NULL,
Foot  varchar(10) NOT NULL,
Joined date NOT NULL,
Contractexpires date NOT NULL,


CONSTRAINT player_licNumber_pk PRIMARY KEY (licenseNumber),
CONSTRAINT player_squadName_fk FOREIGN KEY (SquadName) REFERENCES Squad (SquadName)
);


--  the referee conducts the match.
CREATE TABLE Referee(
RefereeName varchar(20) NOT NULL,
LeagueName varchar(20) NOT NULL,
Matches int NOT NULL, 
Total_yellow_card int NOT NULL,
Total_red_cards int NOT NULL,

CONSTRAINT ref_reffname_pk PRIMARY KEY (RefereeName),
CONSTRAINT ref_LeagueName_fk FOREIGN KEY (LeagueName) REFERENCES League (LeagueName)
);



-- Sponsor supported to the team with some budget. 
CREATE TABLE Sponsors(
SponsorsName varchar(30),
SquadName varchar(30) NOT NULL,
Budget int NOT NULL,

CONSTRAINT sponsor_Sponsorname_pk PRIMARY KEY (SponsorsName),
CONSTRAINT sponsor_squadName_fk FOREIGN KEY (SquadName) REFERENCES Squad (SquadName)
);





-- the whole schedule of games to be played in a championship, indicating when each game is to be played, and which team is to play at home
CREATE TABLE Fixtures(
LeagueName varchar(20) NOT NULL, 
Match_Date date NOT NULL,
RefereeName varchar(20)NOT NULL, 
StadiumName varchar(50) NOT NULL, 
Home_team_name varchar(30) NOT NULL,
Guest_team_name varchar(30)NOT NULL,
Result varchar(5) NOT NULL,

CONSTRAINT fixtur_reffName_fk FOREIGN KEY (RefereeName) REFERENCES Referee (RefereeName),
CONSTRAINT fixtur_LeagueName_fk FOREIGN KEY (LeagueName) REFERENCES League (LeagueName),
CONSTRAINT fixtur_stadName_fk FOREIGN KEY (StadiumName) REFERENCES Stadium (StadiumName)
);

-- squads need to staff for manage the team.
CREATE TABLE Staff(
StaffName varchar(30) NOT NULL,
CONSTRAINT staff_staffName_pk PRIMARY KEY (StaffName)
);

-- Coach directed players. The coach prepares players for matches. Coach has licence and contract. 
CREATE TABLE Coaching(
StaffName varchar(30) NOT NULL,
CoachName varchar(30) NOT NULL,
SquadName varchar(30)  NOT NULL,
License_number varchar(5) NOT NULL,
Appointed date NOT NULL,
Contract_expires date NOT NULL,

CONSTRAINT coach_squadName_fk FOREIGN KEY (SquadName) REFERENCES Squad (SquadName),
PRIMARY KEY(StaffName,CoachName,License_number,Appointed,Contract_expires));


-- Squads have a president for manage squad and work for squad. President work for one squad.
CREATE TABLE President(
StaffName varchar(30) NOT NULL,
PresidentName varchar(30) NOT NULL,
SquadName varchar(30)  NOT NULL,
CONSTRAINT prdent_squadName_fk FOREIGN KEY (SquadName) REFERENCES Squad (SquadName),
PRIMARY KEY(StaffName,PresidentName, SquadName));



-- 2. Insertions(Data manipulation):
-- (15 points)

INSERT INTO League(LeagueName, NumberOfSquad) VALUES ("SUPER LEAGUE", 3);
INSERT INTO League(LeagueName, NumberOfSquad) VALUES ("PREMIER LEAGUE", 3);

INSERT INTO Stadium (StadiumName, Seats) VALUES ("Etihad Stadium", 55017);
INSERT INTO Stadium (StadiumName, Seats) VALUES ("Old Trafford", 74879);
INSERT INTO Stadium (StadiumName, Seats) VALUES ("Anfield", 54074);
INSERT INTO Stadium (StadiumName, Seats) VALUES ("Ali Sami Yen Spor Kompleksi Türk Telekom Stadium", 52223);
INSERT INTO Stadium (StadiumName, Seats) VALUES ("Vodafone Park", 41188);
INSERT INTO Stadium (StadiumName, Seats) VALUES ("Ülker Stadium FB Şükrü Saraçoğlu Sports Complex", 47834);


INSERT INTO Squad(SquadName,LeagueName, StadiumName, Average_Age, Size, Total_market_value, Table_position) 
VALUES ("Galatasaray SK", "SUPER LEAGUE","Ali Sami Yen Spor Kompleksi Türk Telekom Stadium", 27.43,  28,  107066000, 2),
	   ("Besiktas JK", "SUPER LEAGUE", "Vodafone Park", 26.4, 27, 105066000, 1),
       ("Fenerbahce SK", "SUPER LEAGUE", "Ülker Stadium FB Şükrü Saraçoğlu Sports Complex", 28.1,29, 103095000, 3),
       ("Manchester City", "PREMIER LEAGUE", "Etihad Stadium" , 27.2, 24, 1013000000,1),
       ("Manchester United", "PREMIER LEAGUE", "Old Trafford", 27.1,26,788043000,2),
       ("Liverpool FC", "PREMIER LEAGUE", "Anfield", 26.7,29, 1010000000, 3);

INSERT INTO League_table(Season, LeagueName, Table_Position, SquadName, Games_played, Wins, Draws, Losses, Goals_for, Goals_against, Goal_difference, Points)
VALUES ("20/21", "SUPER LEAGUE", 1, "Besiktas JK", 40, 26, 6, 8, 89, 44, 45, 84),
("20/21", "SUPER LEAGUE", 2, "Galatasaray SK", 40, 26, 6,8, 80, 36, 44, 84),
 ("20/21", "SUPER LEAGUE", 3, "Fenerbahce SK", 40, 25, 7, 8, 72, 41, 31, 82),
 ("20/21", "PREMIER LEAGUE", 1, "Manchester City", 38, 27, 5, 6, 83, 32, 51, 86),
 ("20/21", "PREMIER LEAGUE",2, "Manchester United", 38,21,11,6,73,44,29,74),
 ("20/21", "PREMIER LEAGUE",3, "Liverpool FC", 38,20,9,9,68,42,26,69);

INSERT INTO Player(licenseNumber, playerName, SquadName, jerseyNumber, Age, Height,  Country, Marketvalue, Apperances,  
Yellowcards, Redcards, Totalgoals, Assists, Player_position, Foot, Joined, Contractexpires) 
VALUES ("12340", "Ersin Destanoglu","Besiktas JK", 30,20, 195, "Turkey", 5500000,35, 2,1,0,0, "Goalkeeper", "Right","2018-07-1","2019-2-28"),
 ("12341","Utku Yuvakuran", "Besiktas JK", 97,23, 192, "Turkey",660000,6,0,0,0,0,"Goalkeeper", "Right", "2017-08-1","2021-06-30"),
("12342", "Domagoj Vida", "Besiktas JK",24,32,184,"Croatia", 4400000, 34,5,0,5,0,"Centre-Back", "Right", "2018-02-4","2022-06-30"),
 ("12343", "Francisco Montero", "Besiktas JK", 4,22,185,"Spain", 4000000, 13,2,0,0,0,"Centre-Back", "Left", "2020-11-2","2021-12-30"),
 ("12344", "Welinton", "Besiktas JK", 23,32,181, "Brazil", 1760000, 35,9,0,1,2,"Centre-Back", "Right", "2020-08-20","2023-06-30"),
 ("12345","Ridvan Yilmaz", "Besiktas JK",33,20,174,"Turkey", 2009000,18,1,0,1,2,"Left-Back","Left","2020-11-20","2023-06-30"),
 ("12346", "Fabrice N'Sakala",  "Besiktas JK", 21, 30, 178, "DR Congo", 1010000, 29,3,1,1,2,"Left-Back","Left", "2020-08-12","2022-06-30"),
 ("12347","Valentin Rosier","Besiktas JK", 2,24,175,"France", 8025000, 33,8,0,1,7,"Right-Back", "Right", "2020-02-12","2021-06-30"),
 ("12348","Josef", "Besiktas JK", 5,32,188,"Brazil", 7070000, 33,7,1,2,3,"Defensive Midfield", "Right", "2020-07-15","2022-06-30"),
 ("12349","Necip Uysal","Besiktas JK", 20,30,180,"Turkey",1032000,29,4,0,1,4,"Defensive Midfield", "Right", "2009-06-30","2023-08-19"),
 ("12350","Dorukhan Toköz", "Besiktas JK", 26,25,180,"Turkey", 5017000, 31,7,1,0,3,"Central Midfield","Right","2018-07-19","2021-06-30"),
 ("12351","Oguzhan Özyakup", "Besiktas JK", 10,28,180,"Turkey",1098000, 19,0,0,3,2,"Central Midfield","Right","2012-07-1","2022-06-10"),
 ("12352", "Atiba Hutchinson", "Besiktas JK",13,38,187,"Canada", 660000, 36,4,0,4,11,"Central Midfield","Right","2013-06-30","2021-06-30"),
 ("12353","Adem Ljajic", "Besiktas JK", 22,29,182,"Serbia", 6060000,22,3,0,2,4,"Attacking Midfield","Right", "2013-07-1","2022-06-30"),
 ("12354", "Cyle Larin","Besiktas JK", 17,26,188,"Canada", 12010000, 38,3,0,19,6,"Left Winger", "Right",  "2018-01-15","2022-06-30"),
 ("12355"," Georges-Kevin N'Koudou","Besiktas JK", 7,26,172,"France",5050000,32,1,0,8,4,"Left Winger", "Right",  "2019-08-15","2023-06-30"),
 ("12356", "Rachid Ghezzal", "Besiktas JK", 18,29,182,"Algeria", 13020000,31,5,0,8,17,"Right Winger","Left","2020-10-5","2021-06-30"),
 ("12357", "Vincent Aboubakar","Besiktas JK", 14,29,184, "Cameroon", 11000000,26,0,0,15,5,"Centre-Forward", "Right","2020-09-25","2021-06-30"),
 ("12358", "Cenk Tosun","Besiktas JK", 29,29,183,"Turkey", 5050000, 3,0,0,3,1,"Centre-Forward","Right","2021-02-1","2021-06-30"),
 ("12359", "Altay Bayindir","Fenerbahce SK", 1,23,198,"Turkey",15040000, 33,2,0,0,0,"Goalkeeper", "Right","2019-07-19","2023-06-30"),
("12360","Caner Erkin","Fenerbahce SK", 88,32,181,"Turkey", 1065000, 34,8,0,0,9,"Left-Back", "Left","2020-06-19","2022-06-30"),
("12361", "Ozan Tufan","Fenerbahce SK",7,26,182,"Turkey",12010000,37,4,0,6,10,"Central Midfield","Right", "2019-07-01","2023-06-30"),
("12362", "Mesut Özil", "Fenerbahce SK", 67,32,180, "Germany", 4040000, 10,1,0,0,1, "Attacking Midfield","Left", "2021-01-25","2024-06-30"),
("12363", "Fernando Muslera", "Galatasaray SK", 1,34,190,"Uruguay", 4040000, 22,2,0,0,0,"Goalkeeper", "Right","2011-08-11","2024-06-30"),
("12364","Emre Akbaba", "Galatasaray SK", 20,28,180, "Turkey", 2075000, 27,2,0,5,3,"Attacking Midfield", "Left", "2018-08-18","2021-06-30"),
("12365", "Mostafa Mohamed", "Galatasaray SK", 31,23,185,"Egypt", 7015000, 16,2,1,8,0,"Centre-Forward", "Right",  "2021-06-15","2022-06-30"),
("12366", "Falcao", "Galatasaray SK", 9,35,177,"Colombia", 2042000, 17,1,1,9,2,"Centre-Forward", "Right",  "2019-09-11","2022-06-30"),
("12367","Ederson", "Manchester City",31,27,188,"Brazil", 61060000, 36,3,0,0,0,"Goalkeeper","Left", "2017-07-01","2025-06-30"),
("12368","Rodri", "Manchester City", 16,24,191,"Spain", 77000000, 34,6,0,2,2,"Defensive Midfield", "Right", "2019-07-04","2024-06-30"),
("12369", "Neco Williams", "Liverpool FC",76,20,183,"Wales",8080000,6,1,0,0,0,"Right-Back", "Right", "2020-01-04","2025-06-30"),
("12370","James Milner","Liverpool FC", 7, 35, 175, "England", 3030000, 26,3,0,0,1,"Central Midfield","Right", "2015-07-01","2022-06-30"),
("12371","Axel Tuanzebe", "Manchester United",38,23,186,"England", 8080000,9,2,0,0,0,"Centre-Back","Right", "2017-01-01","2022-06-30"),
("12372", "Paul Pogba", "Manchester United", 6,28,191, "France", 66000000, 26,3,0,3,5,"Central Midfield", "Rigth", "2016-08-09","2022-06-30");

INSERT INTO Referee (RefereeName, LeagueName, Matches, Total_yellow_card, Total_red_cards) 
VALUES ("Michael Oliver", "PREMIER LEAGUE", 28, 83, 3),
("Anthony Taylor", "PREMIER LEAGUE", 28, 74, 3),
 ("Martin Atkinson", "PREMIER LEAGUE", 26, 62, 2),
 ("Mike Dean", "PREMIER LEAGUE", 25, 91, 8),
 ("Cüneyt Cakir", "SUPER LEAGUE", 22, 83, 1),
 ("Halil Umut Meler", "SUPER LEAGUE", 22, 111, 5),
 ("Halis Özkahya", "SUPER LEAGUE", 20, 49,1),
("Mete Kalkavan", "SUPER LEAGUE", 20, 83, 0);



INSERT INTO Sponsors (SponsorsName, SquadName, Budget) VALUES ("BEKO", "Fenerbahce SK", 550000);
INSERT INTO Sponsors (SponsorsName, SquadName, Budget) VALUES ("NESINE.COM", "Galatasaray SK", 570000);
INSERT INTO Sponsors (SponsorsName, SquadName, Budget) VALUES ("VODAFONE", "Besiktas JK", 850000);
INSERT INTO Sponsors (SponsorsName, SquadName, Budget) VALUES ("Etihad Airways", "Manchester City", 1024000);
INSERT INTO Sponsors (SponsorsName, SquadName, Budget) VALUES ("CHEVROLET","Manchester United", 982000);
INSERT INTO Sponsors (SponsorsName, SquadName, Budget) VALUES ("Standard Chartered","Liverpool FC", 1015000);



INSERT INTO Fixtures(LeagueName, Match_Date,RefereeName, StadiumName, Home_team_name,Guest_team_name, Result) Values 
("SUPER LEAGUE", "2021-04-12", "Cüneyt Cakir", "Ülker Stadium FB Şükrü Saraçoğlu Sports Complex", "Fenerbahce SK", "Besiktas JK", "1-1"),
("PREMIER LEAGUE", "2021-03-15", "Anthony Taylor", "Anfield", "Liverpool FC", "Manchester City", "3-2"),
("PREMIER LEAGUE", "2021-02-04", "Martin Atkinson", "Etihad Stadium" , "Manchester City", "Manchester United", "3-1");

INSERT INTO Staff(StaffName) VALUES ("COACHING STAFF"),("MANAGEMENT");

INSERT INTO Coaching(StaffName,CoachName, SquadName, License_number,Appointed,Contract_expires) VALUES
("COACHING STAFF", "Jürgen Klopp" , "Liverpool FC", "98760", "2015-08-15","2024-06-30"),
("COACHING STAFF","Pep Guardiola", "Manchester City", "98761", "2016-07-01","2023-06-30"),
("COACHING STAFF", "Ole Gunnar Solskjaer", "Manchester United","98762", "2019-03-28","2022-06-30"),
("COACHING STAFF", "Fatih Terim", "Galatasaray SK","98763", "2017-12-22","2021-06-30"),
("COACHING STAFF","Sergen Yalcin", "Besiktas JK","98764", "2020-01-29","2021-06-30"),
("COACHING STAFF","Emre Belözoglu", "Fenerbahce SK","98765", "2021-03-25","2021-05-17");




INSERT INTO  President(StaffName,PresidentName, SquadName) VALUES 
("BOARD OF DIRECTORS", "Mustafa Cengiz" , "Galatasaray SK"),
("BOARD OF DIRECTORS", "Ahmet Nur Cebi", "Besiktas JK"),
("BOARD OF DIRECTORS", "Ali Koc","Fenerbahce SK"),
("BOARD OF DIRECTORS", "Khaldoon Khalifa Al Mubarak", "Manchester City"),
("BOARD OF DIRECTORS","Sir Kenny Dalglish", "Liverpool FC"),
("BOARD OF DIRECTORS", "Joel Glazer", "Manchester United");



-- Ex:
-- INSERT INTO A1(A) VALUES(1);
-- 3. Queries:
-- (15 points)
-- Write 5 queries with explanations 
-- Write 5 queries. Your queries should do a task that is meaningful in your selected context (project topic). 
-- At least one that joins two or more tables
-- At least one that include group functions
-- At least one with one or more sub-query(es)
-- At least one update
-- At least one delete
-- At least one include arithmetic functions
-- At least one uses alias

-- Ex:
-- Finding all records in A1 table

-- this query shows player's name and market value which is market values higher than avg market value of Besiktas's players and less than "Rodri" playing at "Manchester City". 
-- I used sub-query(es) and alias.
select playerName as "Name of player", Marketvalue as "Price" from player 
where Marketvalue > all(select avg(Marketvalue) from Player where SquadName = "Besiktas JK") 
and  Marketvalue < (select (Marketvalue) from Player where playerName = "Rodri");


-- this query shows which sponsor-supported to which team. I used joins and alias.
select squad.SquadName as "Squad Name", sponsors.SponsorsName as "Sponsor" from squad INNER JOIN sponsors on squad.SquadName= sponsors.SquadName;

-- this query shows the transfer of the person named "Neco Williams" to "Manchester City". I used delete.
update Player set SquadName = "Manchester City" where PlayerName =  "Neco Williams";

-- this query shows the deleting sponsor which is budget smaller than 1M. I used update.
delete from Sponsors where Budget< 1000000;

-- this query shows sum of points which have same position on table in their league table. I used arithmetic functions and group functions.
select Table_Position ,sum(Points) from League_table where Table_Position > (select Table_Position from League_table where SquadName = "Manchester City") group by Table_Position;
