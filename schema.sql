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
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    vet_id INT,
    spec_id INT,
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_species FOREIGN KEY(spec_id) REFERENCES species(id)
);

CREATE TABLE visits (
    vet_id INT,
    anim_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
    CONSTRAINT fk_animals FOREIGN KEY(anim_id) REFERENCES animals(id)
);
