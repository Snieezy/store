CREATE TABLE product
(
  id SERIAL PRIMARY KEY,
  name Varchar(50) NOT NULL,
  price MONEY NOT NULL,
  vat NUMERIC(2,2) NOT NULL,
  quantity INTEGER NOT NULL CHECK (quantity >= 0),
  warehouse_id SERIAL REFERENCES warehouse ON DELETE CASCADE NOT NULL
  CHECK (vat < 1.0),
  CHECK (vat >= 0)
);

CREATE TABLE basket
(
  id SERIAL PRIMARY KEY,
  product_id SERIAL REFERENCES product ON DELETE CASCADE
);

CREATE TABLE warehouse
(
  id SERIAL PRIMARY KEY,
);
