-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;
\c tournament;



CREATE TABLE players (
	id serial primary key,
	name text
);

CREATE TABLE matches (
	id serial primary key,
	winner int references players(id),
	loser int references players(id)
);

CREATE VIEW wins AS
SELECT players.id, COUNT(matches.winner)
FROM players LEFT JOIN matches
ON players.id = matches.winner

CREATE VIEW total_matches AS
SELECT players.id, (SELECT COUNT(*) from matches WHERE players.id = matches.winner or players.id = matches.loser)
FROM players

CREATE VIEW standings AS
SELECT players.id, players.name, wins.win, total_matches.matches
FROM players, total_matches, wins
WHERE players.id = wins.id = total_matches.id;
