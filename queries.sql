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

-- What animals belong to Melody Pond?
  SELECT full_name, owners.id, name, owner_id
  FROM owners
  INNER JOIN animals
  ON owners.id = owner_id
  WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
  SELECT
  species.name, species.id, species_id, animals.name
  FROM species
  INNER JOIN animals
  ON species.id = species_id
  WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
  SELECT
  full_name, owners.id, name, owner_id
  FROM owners
  LEFT JOIN animals
  ON owners.id = owner_id;

-- How many animals are there per species?
  SELECT
  species.name, COUNT(species_id)
  FROM species
  INNER JOIN animals
  ON species.id = species_id
  GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
  SELECT
  full_name, owners.id, animals.name
  FROM owners
  INNER JOIN animals
  ON owners.id = owner_id
  WHERE full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
  SELECT
  animals.name, escape_attempts, full_name
  FROM owners
  INNER JOIN animals
  ON owners.id = owner_id
  WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
  SELECT
  full_name, COUNT(name)
  FROM owners
  LEFT JOIN animals
  ON owner_id = owners.id
  GROUP BY full_name
  ORDER BY COUNT DESC;


-- add "join table" for visits Activity

  -- Who was the last animal seen by William Tatcher?
  SELECT animals.name , visit_date
  FROM visits
  INNER JOIN vets
  ON vets.id = visits.vet_id
  INNER JOIN animals 
  ON animals.id = visits.animal_id
  WHERE vets.name = 'William Tatcher'
  ORDER BY visit_date DESC
  LIMIT 1;
  -- How many different animals did Stephanie Mendez see?
  SELECT COUNT(visits.vet_id)
  from visits
  RIGHT JOIN vets
  ON vets.id = visits.vet_id
  WHERE vets.name = 'Stephanie Mendez';
  -- List all vets and their specialties, including vets with no specialties.
  SELECT vets.name, species.name
  FROM vets
  LEFT JOIN specializations
  ON vets.id = specializations.vet_id
  LEFT JOIN  species
  ON species.id = specializations.species_id
  -- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
  SELECT animals.name, visits.visit_date
  FROM visits
  INNER JOIN vets
  ON vets.id = visits.vet_id
  INNER JOIN animals
  ON animals.id = visits.animal_id
  WHERE visit_date BETWEEN '2020-4-1' AND '2020-8-30';
  -- What animal has the most visits to vets?
  SELECT animals.name, COUNT(animals.name)
  FROM visits
  INNER JOIN animals
  ON animals.id = visits.animal_id
  GROUP BY animals.name
  ORDER BY count DESC
  LIMIT 1;
  -- Who was Maisy Smith's first visit?
  SELECT animals.name , visit_date
  FROM visits
  INNER JOIN vets
  ON vets.id = visits.vet_id
  INNER JOIN animals
  ON animals.id = visits.animal_id
  WHERE vets.name = 'Maisy Smith'
  ORDER BY visit_date
  LIMIT 1;
  -- Details for most recent visit: animal information, vet information, and date of visit.
  SELECT animals.*, visits.visit_date, vets.name, vets.age, vets.date_of_graduation
  FROM visits
  INNER JOIN animals
  ON animals.id = visits.animal_id
  INNER JOIN vets
  ON vets.id = visits.vet_id;
  -- How many visits were with a vet that did not specialize in that animal's species?
  SELECT COUNT(animals.name)
  FROM animals
  INNER JOIN visits
  ON animal_id= animals.id
  INNER JOIN vets
  ON vet_id=vets.id
  WHERE animals.species_id NOT IN((SELECT species_id FROM specializations WHERE vet_id=visits.vet_id));
  -- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name
FROM animals
INNER JOIN visits
ON animals.id=animal_id
INNER JOIN vets
ON visits.vet_id=vets.id
INNER JOIN species
ON animals.species_id=species.id
WHERE vets.name='Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;


