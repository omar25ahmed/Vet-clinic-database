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


-- Insert the following data into the owners table:
	INSERT INTO owners (full_name, age)
	VALUES
		('Sam Smith', 34),
		('Jennifer Orwell', 19),
		('Bob', 45),
		('Melody Pond', 77),
		('Dean Winchester', 14),
		('Jodie Whittaker', 38);

-- Insert the following data into the species table:
	INSERT INTO species (name)
	VALUES
		('Pokemon'),
		('Digimon');

-- Modify your inserted animals so it includes the species_id
	UPDATE animals
	SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
	WHERE name LIKE '%mon';

	UPDATE animals
	SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
	WHERE name NOT LIKE '%mon';


-- -- Modify your inserted animals so it includes the owner_id
	UPDATE animals
	SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
	WHERE name = 'Agumon';

	UPDATE animals
	SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
	WHERE name IN ('Gabumon', 'Pikachu');


	UPDATE animals
	SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
	WHERE name IN ('Devimon', 'Plantmon');

	UPDATE animals
	SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
	WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

	UPDATE animals
	SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
	WHERE name IN ('Angemon', 'Boarmon');



-- add "join table" for visits Activity

INSERT INTO vets (name,age,date_of_graduation)
VALUES
('William Tatcher',45,'2000-04-23'),
('Maisy Smith',26,'2019-01-17'),
('Stephanie Mendez',64,'1981-05-04'),
('Jack Harkness',38,'2008-06-08');

INSERT INTO specializations (vet_id, spec_id) 
VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon')),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon')),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

INSERT INTO visits (vet_id, anim_id, date_of_visit)
VALUES
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
((SELECT id FROM vets WHERE name = ' William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');