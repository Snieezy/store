CREATE TABLE product
(
  id SERIAL PRIMARY KEY,
  name Varchar(50) NOT NULL,
  price MONEY NOT NULL,
  vat DECIMAL(1,2) NOT NULL CHECK (Vat < 1.0 && Vat >= 0),
  quantity INTEGER NOT NULL CHECK (Quantity > 0)
);
