-- Задание 1
-- 1. Название и продолжительность самого длительного трека.
SELECT title_track , MAX(duration) FROM track 
GROUP BY title_track
ORDER BY MAX(duration) DESC;

-- 2. Название треков, продолжительность которых не менее 3,5 минут
SELECT title_track, duration 
FROM track
WHERE '00:03:30' <= duration; 

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title_collection 
FROM collection
WHERE year_of_release  BETWEEN '2018-01-01' AND '2020-12-31';  

-- 4. Исполнители, чьё имя состоит из одного слова.
SELECT nickname  
FROM  executor
WHERE nickname NOT LIKE '%% %%'; 

-- 5. Названия треков, содержащие слово <мой> или <my>
SELECT title_track 
FROM track
WHERE lower(title_track) like 'мой %' or lower(title_track) like '% мой' or lower(title_track) like '% мой %' or lower(title_track) like 'мой'
or lower(title_track) like 'my %' or lower(title_track) like '% my' or lower(title_track) like '% my %' or lower(title_track) like 'my';

-- Задание 3
-- 1. Количество исполнителей в каждом жанре.
SELECT name_, COUNT(genre_id)
FROM genre_of_music gm
JOIN genre_and_executor gae ON gm.id = gae.genre_id 
GROUP BY name_; 

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(album_id) 
FROM album a 
JOIN track t ON a.id = t.album_id
WHERE year_of_release BETWEEN '2019-01-01' AND '2020-12-31';

-- 3. Средняя продолжительность треков по каждому альбому.
SELECT title, AVG(duration)
FROM album a
JOIN track t ON a.id = t.album_id  
GROUP BY title;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT nickname
FROM executor e 
WHERE nickname NOT IN(
	SELECT nickname 
	FROM executor e
	JOIN album_executor ae ON e.id = ae.executor_id 
	JOIN album a ON ae.executor_id = a.id
	WHERE EXTRACT(YEAR FROM year_of_release) = '2020'
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами). В данном случае Мельница
SELECT DISTINCT title_collection 
FROM collection c 
JOIN track_collection tc ON c.id = tc.collection_id  
JOIN track t ON tc.track_id = t.id 
JOIN album a ON t.album_id  = a.id 
JOIN album_executor ae ON a.id = ae.album_id  
JOIN executor e ON ae.executor_id  = e.id  
WHERE nickname = 'Мельница';

-- Задание 4
-- 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT DISTINCT title
FROM album a 
JOIN album_executor ae ON a.id = ae.album_id  
JOIN executor e ON ae.album_id  = e.id 
JOIN genre_and_executor gae ON e.id = gae.genre_id  
GROUP BY title, gae.executor_id 
HAVING COUNT(genre_id) > 1;

-- 2. Наименования треков, которые не входят в сборники.
SELECT title_track 
FROM track t
LEFT JOIN track_collection tc ON t.id = tc.track_id  
WHERE track_id IS NULL;

-- 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек, — теоретически таких треков может быть несколько.
SELECT nickname, t.duration 
FROM executor e 
JOIN album_executor ae ON e.id = ae.executor_id 
JOIN album a ON ae.album_id = a.id 
JOIN track t ON a.id = t.album_id
WHERE t.duration IN (SELECT MIN(duration) FROM track);

-- 4. Названия альбомов, содержащих наименьшее количество треков
SELECT title
FROM album a 
JOIN track t ON a.id = t.album_id
GROUP BY title
HAVING COUNT(t.id) = (
	SELECT COUNT(t.id) FROM track t
	GROUP BY t.id 
	ORDER BY 1
	LIMIT 1
);

