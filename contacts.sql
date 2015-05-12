CREATE TABLE contacts (
  id        serial NOT NULL PRIMARY KEY,
  firstname varchar(40) NOT NULL,
  lastname  varchar(40) NOT NULL,
  email     varchar(40) NOT NULL
);

INSERT INTO contacts (firstname, lastname, email) VALUES
  ('Simon', 'Pregent', 'simon.pregent@hec.ca'),
  ('Maryeve', 'Vermette', 'maryeve31@hotmail.com'),
  ('Joe', 'Blo', 'joe.blo@email.com'),
  ('Max', 'Powers', 'max.powers@email.ca');
