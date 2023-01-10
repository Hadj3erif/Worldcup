#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL " SELECT sum(winner_goals+opponent_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT avg(winner_goals) from games" )"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT round(avg(winner_goals),2) from games" )"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL " SELECT avg(winner_goals+opponent_goals) from games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT max(winner_goals) from games" )"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT count(*) from games where winner_goals > 2" )"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name from teams as t left join games as g on t.team_id=g.winner_id where year = '2018' and round = 'Final' " )"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name from teams as t left join games as g on t.team_id=g.winner_id where year = '2014' and round = 'Eighth-Final' UNION ALL SELECT name from teams as t left join games as g on t.team_id=g.opponent_id where year = '2014' and round = 'Eighth-Final' order by name  " )"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT distinct name from games as g left join teams as t on g.winner_id=t.team_id ORDER BY name" )"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name from teams as t left join games as g on t.team_id=g.winner_id where round = 'Final' ORDER BY year" )"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams where name like 'Co%'" )"