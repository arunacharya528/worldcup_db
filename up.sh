#! /bin/bash

PSQL="psql --username=postgres --dbname=worldcup --no-align --tuples-only -c"

echo "$($PSQL "
CREATE TABLE teams(
  team_id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) UNIQUE NOT NULL
);
")"

echo "$($PSQL "
CREATE TABLE games(
  game_id SERIAL PRIMARY KEY NOT NULL,
  year INTEGER NOT NULL,
  round VARCHAR(255) NOT NULL,
  winner_id INTEGER REFERENCES teams(team_id) NOT NULL,
  opponent_id INTEGER REFERENCES teams(team_id) NOT NULL,
  winner_goals INTEGER NOT NULL,
  opponent_goals INTEGER NOT NULL
);
")"
