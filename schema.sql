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