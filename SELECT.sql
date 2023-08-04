-- Задание 1
-- 1. Название и продолжительность самого длительного трека.
SELECT title_track , MAX(duration) FROM track 
GROUP BY title_track
ORDER BY MAX(duration) DESC;

-- 2. Название треков, продолжительность которых не менее 3,5 минут
SELECT title_track
FROM track
WHERE '00:03:05' < duration; 

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title_collection 
FROM collection
WHERE year_of_release  BETWEEN '2022-01-01' AND '2023-01-01';  

-- 4. Исполнители, чьё имя состоит из одного слова.
SELECT nickname  
FROM  executor
WHERE nickname NOT LIKE '%% %%'; 

/* 5. Названия треков, содержащие слово <мой> или <my>, в данных данной таблицы таких треков нет, потому просто найдем, где встречается <e>, русская и английская */
SELECT title_track 
FROM track
WHERE title_track LIKE '%е%' OR title_track LIKE '%e%';

-- Задание 3
-- 1. Количество исполнителей в каждом жанре.
SELECT name_, COUNT(genre_id)
FROM genre_of_music gm
JOIN genre_and_executor gae ON gm.id = gae.genre_id 
GROUP BY name_; 

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT title, COUNT(album_id) 
FROM album a 
JOIN track t ON a.id = t.album_id
WHERE year_of_release BETWEEN '2019-01-01' AND '2021-01-01'
GROUP BY title; 

-- 3. Средняя продолжительность треков по каждому альбому.
SELECT title, AVG(duration)
FROM album a
JOIN track t ON a.id = t.album_id  
GROUP BY title;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT nickname
FROM executor e 
JOIN album a ON e.id = a.id  
WHERE EXTRACT(YEAR FROM year_of_release) != '2020'
GROUP BY nickname; 

-- 5. Названия сборников, в которых присутствует конкретный исполнитель (выберите его сами). В данном случае Мельница
SELECT title_collection, COUNT(e.id)
FROM collection c 
JOIN executor e ON c.id = e.id 
WHERE nickname LIKE '%Мельница%'
GROUP BY title_collection; 

-- Задание 4
-- 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT title, COUNT(genre_id)
FROM album a 
JOIN album_executor ae ON a.id = ae.album_id
JOIN executor e ON ae.executor_id = e.id 
JOIN genre_and_executor gae ON e.id = gae.executor_id 
GROUP BY title 
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
SELECT title, COUNT(t.id)
FROM album a 
JOIN track t ON a.id = t.album_id
GROUP BY title
HAVING COUNT(t.id) < 2
ORDER BY COUNT(t.id)
