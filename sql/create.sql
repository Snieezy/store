CREATE TABLE product
(
  id SERIAL PRIMARY KEY,
  name Varchar(50) NOT NULL,
  price MONEY NOT NULL,
  vat NUMERIC(2,2) NOT NULL,
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  CHECK (vat < 1.0),
  CHECK (vat >= 0)
);

CREATE TABLE basket
(
  id SERIAL PRIMARY KEY
);
