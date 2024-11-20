#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# -------------------------------------
# Truncate all old data
# -------------------------------------

echo "$($PSQL "TRUNCATE TABLE teams, games CASCADE;")";

# -------------------------------------
# Insert into teams table
# -------------------------------------

index=0
while IFS=, read -r year round winner opponent winner_goals opponent_goals
do

  if [ $index -ne 0 ]; then

    echo "$($PSQL"INSERT INTO teams (name) VALUES ('$winner') ON CONFLICT DO NOTHING;")";

    echo "$($PSQL"INSERT INTO teams (name) VALUES ('$opponent') ON CONFLICT DO NOTHING;")";
    
  fi

  index=$((index+1));

done < games.csv


# -------------------------------------
# Insert into games table
# -------------------------------------

index=0
while IFS=, read -r year round winner opponent winner_goals opponent_goals
do
  if [ $index -ne 0 ]; then
  
    winner_id="$($PSQL "SELECT team_id from teams WHERE name = '$winner';")";
    opponent_id="$($PSQL "SELECT team_id from teams WHERE name = '$opponent';")";

    echo "$($PSQL "
    INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
    VALUES ($year, '$round' ,$winner_id ,$opponent_id , $winner_goals , $opponent_goals)
    ON CONFLICT DO NOTHING;
    ")"

  fi
  
  index=$((index+1));
done < games.csv
