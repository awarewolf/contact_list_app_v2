CREATE TABLE phone_numbers (
  id  SERIAL NOT NULL PRIMARY KEY,
  contact_id  INTEGER REFERENCES contacts (id),
  phone_number  TEXT NOT NULL,
  location TEXT -- Mobile, home, work
);
