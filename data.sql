/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', 0, 'true', 10.23),
('Gabumon', '2018-11-2018', 2, 'false', 8)
('Pikachu', '2021-01-7', 1, 'false', 15.04)
('Devimon', '2017-05-12', 5, 'true', 11);

-- Insert new data to the animale table
INSERT INTO
animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
	('Charmander', '2020-02-08', 0, 'false', 11),
	('Plantmon', '2021-11-15', 2, 'true', 5.7),
	('Squirtle', '1993-04-02', 3, 'false', 12.13),
	('Angemon', '2005-07-12', 1, 'true', 45),
	('Boarmon', '2005-07-07', 7, 'true', 20.4),
	('Blossom', '1998-10-13', 3, 'true', 17),
	('Ditto', '2022-05-14', 4, 'true', 22);

-- First Transaction
    -- Begin the transaction
    BEGIN;
    -- Set the condition (update the species column to be inspecified)
    UPDATE animals
    SET species = 'unspecified';
    -- Then undo these changes by roll back
    ROLLBACK;

-- Second Transaction
  -- Begin the transaction
      BEGIN;
  -- Set the condition (update the species column Where the name ends with 'mon')
    UPDATE animals
    SET species = 'digimon'
    WHERE name LIKE '%mon';
  -- Set the condition (update the species column Where the name doesn't end with 'mon')
    UPDATE animals
    SET species = 'pokemon'
    WHERE name NOT LIKE '%mon';
  -- Last step to save the changes
    COMMIT;

-- Third Transaction
    -- Begin the transaction
      BEGIN;
    -- Delete the table from the database
      DROP TABLE animals;
    -- Check if the table exists
      SELECT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'animals');
      -- returns false
    -- undo the changes by rollback
      ROLLBACK;
    -- Check if the table exists
      SELECT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename  = 'animals');
      -- return true

-- Fourth Transaction
  -- Begin the transaction
    BEGIN;
  -- Delete the animals where got born after 2022
    WHERE date_of_birth >= '2022-01-01';
  -- Do a savepoint
    SAVEPOINT delete_animals;
  -- make the weight to be negative
    UPDATE animals SET weight_kg = weight_kg * (-1);
  -- Rollback to the first savepoint
    ROLLBACK TO delete_animals;
  -- Modify the weight to be all positive
    UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
  -- Then commit that changes
    COMMIT;
    