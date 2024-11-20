#! /bin/bash

PSQL="psql --username=postgres --dbname=worldcup --no-align --tuples-only -c"

echo "$($PSQL "
DROP TABLE IF EXISTS games;
")"

echo "$($PSQL "
DROP TABLE IF EXISTS teams;
")"
