INSERT INTO executor(nickname) 
VALUES('Imagine Dragons'),('Мельница'), ('Би-2'), ('Keane'), ('Caravan Palace'), ('Мария Чайковская')

INSERT INTO genre_of_music(name_)
VALUES('Фолк-рок'), ('Альтернативный рок'), ('Электро-свинг'), ('Джаз-фолк')

INSERT INTO album(title, year_of_release)
VALUES('<I°_°I>', '2015-10-16'), ('Cause And Effect', '20/09/2019'), ('Аллилуйя', '15/11/2022'), ('2.0', '22/09//2019'), ('Mercury-Act 1', '03/09/2021'), ('Ангелофрения', '2012-04-28'), ('Темные небеса', '2014-01-01')


INSERT INTO track(album_id, title_track, duration)
VALUES(3, 'Красота', '00:04:31'), (4, 'Бес джиги', '00:04:20'), (2, 'Stupid Things', '00:03:21'), (5, 'Enemy', '00:02:21'), (1, 'Lone Digger', '00:03:49'), (3, 'Аллилуйя', '00:04:11'), (6, 'Дороги', '00:03:38'), (5, 'Follow You', '00:02:49'), (7, 'Дайте огня', '00:03:33')

INSERT INTO collection(title_collection, year_of_release)
VALUES('Everybody Wants to Be My Enemy', '2022-07-11'), ('Navigator Records 15', '2021-04-21'), ('Лечим зимнюю хандру', '2022-02-12'),  ('Альянс Tribute', '2022-09-17')

INSERT INTO genre_and_executor(executor_id, genre_id)
VALUES(1, 2), (2, 1), (3, 2), (4, 2), (5, 3), (6, 4)

INSERT INTO album_executor(executor_id, album_id)
VALUES(1, 5), (2, 4), (2, 6), (3, 3), (3, 7), (4, 2), (5, 1), (6, 3)

INSERT INTO track_collection (track_id, collection_id)
VALUES(4, 1), (9, 4), (7, 2), (8, 3)
