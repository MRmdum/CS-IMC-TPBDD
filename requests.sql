-- 0) Description BDD
SELECT * FROM INFORMATION_SCHEMA.TABLES;
SELECT * from tJob;
select * from tArtist;
select * from tFilm;

-- 1) Pas de Bradd Pit dans la base 
select birthYear from tArtist where primaryName like 'Brad Potts';

-- 2) D

-- 3) Liste l'ensemble des noms d'artiste en filtrant par l'année 1960 précisemment
SELECT primaryName from tArtist where birthYear = 1960;
-- compte des lignes retourné par la même requête, ce qui nous donne le nombre
SELECT count(*) from tArtist where birthYear = 1960;

SELECT TOP 1 birthYear, COUNT(*) AS nombre_acteurs
FROM tArtist
WHERE birthYear != 0
GROUP BY birthYear
ORDER BY nombre_acteurs DESC;

SELECT TOP 5 artist.primaryName, COUNT(DISTINCT job.idFilm) AS nombre_films
FROM tJob as job
JOIN tArtist as artist ON job.idArtist = artist.idArtist
WHERE category = 'acted in'
GROUP BY artist.primaryName
ORDER BY nombre_films DESC;

SELECT tArtist.primaryName, COUNT(Distinct tJob.category) as nombre_jobs from tJob 
JOIN tArtist on tJob.idArtist = tArtist.idArtist
GROUP BY primaryName
ORDER BY nombre_jobs DESC;

SELECT TOP 1 WITH TIES f.primaryTitle, COUNT(j.idArtist) AS nombre_acteurs
FROM tJob j
JOIN tFilm f ON j.idFilm = f.idFilm
WHERE j.category = 'acted in'
GROUP BY f.primaryTitle
ORDER BY COUNT(j.idArtist) DESC;

SELECT a.primaryName AS artiste, f.primaryTitle AS film, Count(distinct j.category) AS nb_responsabilités
FROM tJob j
JOIN tArtist a ON j.idArtist = a.idArtist
JOIN tFilm f ON j.idFilm = f.idFilm
GROUP BY a.primaryName, f.primaryTitle
HAVING COUNT(DISTINCT j.category) > 1
ORDER BY film;
