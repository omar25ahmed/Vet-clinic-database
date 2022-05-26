/* Database schema to keep the structure of entire database. */
-- Connect to the server
> psql

-- Create the database
CREATE DATABASE vet_clinic

-- Connect to the database
\c vet_clinic

-- Create table:
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    date_of_birth DATETIME,
    escape_attempts INT,
    neutered TEXT,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

-- Add a column species of type string to your animals table
ALTER TABLE animals
		ADD species TEXT;

-- Create a table named owners:
    CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
	age INT,
    PRIMARY KEY(id)
);

-- Create a table named species
    CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
	PRIMARY KEY(id)
);


-- Modify animals table
    BEGIN;

    ALTER TABLE animals
    DROP COLUMN species;

    ALTER TABLE animals ADD COLUMN species_id INT;

    ALTER TABLE animals
    ADD CONSTRAINT fk_species
    FOREIGN KEY (species_id)
    REFERENCES species (id);

    ALTER TABLE animals ADD COLUMN owner_id INT;

    ALTER TABLE animals
    ADD CONSTRAINT fk_owner
    FOREIGN KEY (owner_id)
    REFERENCES owners (id);

    COMMIT;

-- add "join table" for visits Activity
CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR(250),
age INTEGER,
date_of_graduation DATE
);

CREATE TABLE specializations(
  vet_id INTEGER,
  species_id INTEGER
);

CREATE TABLE visits(
animal_id INTEGER,
vet_id INTEGER,
visit_date DATE
);
