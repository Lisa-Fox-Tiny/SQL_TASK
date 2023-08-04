CREATE TABLE IF NOT EXISTS Collection (
	id SERIAL PRIMARY KEY,
	title_collection VARCHAR(60) NOT NULL,
	year_of_release date
);

CREATE TABLE IF NOT EXISTS Album (
	id SERIAL PRIMARY KEY,
	title VARCHAR(60) NOT NULL,
	year_of_release date
);

CREATE TABLE IF NOT EXISTS Track (
	id SERIAL PRIMARY KEY,
	album_id INTEGER NOT NULL REFERENCES Album(id),
	title_track VARCHAR(60) NOT NULL,
	duration interval minute to second
);

CREATE TABLE IF NOT EXISTS Track_collection (
	id SERIAL PRIMARY KEY,
	track_id INTEGER REFERENCES Track(id),
	Collection_id INTEGER REFERENCES Collection(id)
);

CREATE TABLE IF NOT EXISTS Executor (
	id SERIAL PRIMARY KEY,
	nickname VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Album_executor (
	executor_id INTEGER REFERENCES Executor(id),
	album_id INTEGER REFERENCES Album(id),
	CONSTRAINT pk PRIMARY KEY (executor_id, album_id)
);

CREATE TABLE IF NOT EXISTS Genre_of_music (
	id SERIAL PRIMARY KEY,
	name_ VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS Genre_and_executor (
	executor_id INTEGER REFERENCES Executor(id),
	genre_id INTEGER REFERENCES Genre_of_music(id),
	CONSTRAINT pk_1 PRIMARY KEY (executor_id, genre_id)
);



