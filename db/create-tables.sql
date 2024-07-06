CREATE TABLE IF NOT EXISTS Films
(
    Id integer NOT NULL PRIMARY KEY,
    Name text NOT NULL,
    Year integer NOT NULL
);

CREATE TABLE IF NOT EXISTS Actors
(
    Id integer NOT NULL PRIMARY KEY,
    Name text NOT NULL,
    Age int NOT NULL
);