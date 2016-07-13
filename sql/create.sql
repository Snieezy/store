CREATE TABLE Product
(
  ID SERIAL PRIMARY KEY,
  Name Varchar(50) NOT NULL,
  Price MONEY NOT NULL,
  Vat DECIMAL(1,2) NOT NULL CHECK (Vat < 1.0 && Vat >= 0),
  Quantity INTEGER NOT NULL CHECK (Quantity > 0)
);
