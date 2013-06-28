DROP TABLE contacts;
CREATE TABLE contacts
(
  id SERIAL PRIMARY KEY,
  first VARCHAR(25),
  last VARCHAR(25),
  age INT,
  gender CHAR(1),
  dtgt BOOLEAN,
  phone VARCHAR(12)
);
