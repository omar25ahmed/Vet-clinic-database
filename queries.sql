/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';
-- List the name of all animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '%2019-12-30';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts <= 3;
-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg >  10.5;
-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = 'true';
-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name <> 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


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
    WHERE species IS NULL;
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
    DELETE FROM animals
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



-- How many animals are there? 10
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts)
FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS escape_attempts
FROM animals
GROUP BY neutered
ORDER BY escape_attempts DESC;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-01'
GROUP BY species;
