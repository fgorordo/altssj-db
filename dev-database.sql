CREATE TYPE "invoice_status" AS ENUM (
  'paid',
  'unpaid'
);

CREATE TYPE "slot_type" AS ENUM (
  'roof',
  'no_roof'
);

CREATE TYPE "customer_status" AS ENUM (
  'active',
  'inactive'
);

CREATE TABLE "payments" (
  "payment_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "invoice_id" integer,
  "payment_date" timestamp,
  "amount" decimal(10,2),
  "created_at" timestamp DEFAULT 'now()'
);

CREATE TABLE "invoices" (
  "invoice_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "customer_id" integer,
  "total_amount" decimal(10,2),
  "due_date" timestamp,
  "status" invoice_status
);

CREATE TABLE "invoice_items" (
  "item_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "invoice_id" integer,
  "slot_id" integer,
  "amount" "DECIMAL(10, 2)",
  "start_date" timestamp,
  "end_date" timestamp
);

CREATE TABLE "parking_slots" (
  "slot_id" SERIAL PRIMARY KEY,
  "slot_name" varchar,
  "location" varchar,
  "slot_type" slot_type,
  "rate_per_month" decimal(10,2),
  "current_customer" integer
);

CREATE TABLE "customers" (
  "customer_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "fist_name" varchar,
  "last_name" varchar,
  "email" varchar,
  "phone" varchar,
  "status" customer_status
);

CREATE TABLE "cars" (
  "car_id" INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "customer_id" integer,
  "patent" varchar,
  "fabricant" varchar,
  "model" varchar
);

ALTER TABLE "payments" ADD FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("invoice_id");

ALTER TABLE "invoices" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("customer_id");

ALTER TABLE "invoice_items" ADD FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("invoice_id");

ALTER TABLE "invoice_items" ADD FOREIGN KEY ("slot_id") REFERENCES "parking_slots" ("slot_id");

ALTER TABLE "parking_slots" ADD FOREIGN KEY ("current_customer") REFERENCES "customers" ("customer_id");

ALTER TABLE "cars" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("customer_id");


INSERT INTO "customers" ("fist_name", "last_name", "email", "phone", "status")
VALUES
  ('John', 'Doe', 'john.doe@example.com', '+1234567890', 'active'),
  ('Jane', 'Smith', 'jane.smith@example.com', '+9876543210', 'active'),
  ('Michael', 'Johnson', 'michael.johnson@example.com', '+1112223334', 'inactive'),
  ('Alice', 'Johnson', 'alice.johnson@example.com', '+1122334455', 'active'),
  ('Bob', 'Smith', 'bob.smith@example.com', '+9988776655', 'active'),
  ('Eve', 'Anderson', 'eve.anderson@example.com', '+5544332211', 'inactive'),
  ('David', 'Lee', 'david.lee@example.com', '+7766554433', 'active'),
  ('Sarah', 'Wang', 'sarah.wang@example.com', '+1122334455', 'inactive'),
  ('Michael', 'Brown', 'michael.brown@example.com', '+9988776655', 'active'),
  ('Emily', 'Taylor', 'emily.taylor@example.com', '+5544332211', 'active'),
  ('Daniel', 'Chen', 'daniel.chen@example.com', '+3322114455', 'inactive');

INSERT INTO "parking_slots" ("slot_name", "location", "slot_type", "rate_per_month", "current_customer")
VALUES
  ('Slot 1', 'Parking Lot A', 'roof', 150.00, NULL),
  ('Slot 2', 'Parking Lot B', 'roof', 150.00, NULL),
  ('Slot 3', 'Parking Lot C', 'no_roof', 100.00, 1),
  ('Slot 4', 'Parking Lot D', 'no_roof', 100.00, NULL),
  ('Slot 5', 'Parking Lot E', 'roof', 180.00, 2),
  ('Slot 6', 'Parking Lot F', 'roof', 180.00, 3),
  ('Slot 7', 'Parking Lot G', 'no_roof', 120.00, NULL),
  ('Slot 8', 'Parking Lot H', 'no_roof', 120.00, 1),
  ('Slot 9', 'Parking Lot I', 'roof', 180.00, 4),
  ('Slot 10', 'Parking Lot J', 'roof', 180.00, 5),
  ('Slot 11', 'Parking Lot K', 'no_roof', 120.00, NULL),
  ('Slot 12', 'Parking Lot L', 'no_roof', 120.00, 2),
  ('Slot 13', 'Parking Lot M', 'roof', 200.00, NULL);
  


INSERT INTO "cars" ("customer_id", "patent", "fabricant", "model")
VALUES
  (1, 'ABC123', 'Toyota', 'Camry'),
  (1, 'XYZ789', 'Honda', 'Civic'),
  (2, 'DEF456', 'Ford', 'Fusion'),
  (2, 'JKL987', 'Nissan', 'Altima'),
  (3, 'MNO654', 'Chevrolet', 'Cruze'),
  (4, 'PQR321', 'Hyundai', 'Elantra'),
  (5, 'STU987', 'Subaru', 'Forester'),
  (2, 'VWX654', 'Volkswagen', 'Passat'),
  (6, 'YZA321', 'Kia', 'Sorento'),
  (7, 'BCD456', 'BMW', 'X5'),
  (8, 'EFG789', 'Mercedes', 'C-Class');
  

INSERT INTO "invoices" ("customer_id", "total_amount", "due_date", "status")
VALUES
  (1, 300.00, '2023-08-20', 'unpaid'),
  (2, 200.00, '2023-08-25', 'unpaid'),
  (3, 150.00, '2023-08-15', 'paid'),
  (4, 220.00, '2023-08-15', 'unpaid'),
  (3, 180.00, '2023-08-10', 'paid'),
  (2, 270.00, '2023-08-25', 'unpaid'),
  (7, 310.00, '2023-08-18', 'unpaid'),
  (5, 180.00, '2023-08-12', 'paid'),
  (8, 250.00, '2023-08-22', 'unpaid'),
  (6, 220.00, '2023-08-14', 'unpaid'),
  (9, 280.00, '2023-08-25', 'unpaid');

INSERT INTO "invoice_items" ("invoice_id", "slot_id", "amount", "start_date", "end_date")
VALUES
  (1, 1, 150.00, '2023-08-01', '2023-08-31'),
  (1, 2, 150.00, '2023-08-01', '2023-08-31'),
  (2, 3, 200.00, '2023-08-01', '2023-08-31'),
  (3, 3, 150.00, '2023-08-01', '2023-08-31'),
  (4, 3, 120.00, '2023-08-01', '2023-08-31'),
  (4, 4, 100.00, '2023-08-01', '2023-08-31'),
  (5, 5, 180.00, '2023-08-01', '2023-08-31'),
  (6, 6, 180.00, '2023-08-01', '2023-08-31'),
  (6, 7, 90.00, '2023-08-01', '2023-08-31'),
  (7, 11, 120.00, '2023-08-01', '2023-08-31'),
  (7, 13, 190.00, '2023-08-01', '2023-08-31'),
  (8, 12, 180.00, '2023-08-01', '2023-08-31'),
  (9, 9, 200.00, '2023-08-01', '2023-08-31'),
  (10, 10, 180.00, '2023-08-01', '2023-08-31');

INSERT INTO "payments" ("invoice_id", "payment_date", "amount", "created_at")
VALUES
  (1, '2023-08-05', 100.00, '2023-08-05 12:00:00'),
  (2, '2023-08-10', 150.00, '2023-08-10 14:30:00'),
  (3, '2023-08-01', 150.00, '2023-08-01 10:00:00'),
  (7, '2023-08-08', 200.00, '2023-08-08 12:00:00'),
  (7, '2023-08-15', 100.00, '2023-08-15 14:30:00'),
  (8, '2023-08-10', 180.00, '2023-08-10 16:45:00'),
  (9, '2023-08-05', 220.00, '2023-08-05 10:00:00'),
  (10, '2023-08-01', 150.00, '2023-08-01 11:00:00'),
  (4, '2023-08-05', 220.00, '2023-08-05 12:00:00'),
  (5, '2023-08-10', 150.00, '2023-08-10 14:30:00'),
  (5, '2023-08-15', 50.00, '2023-08-15 16:45:00'),
  (6, '2023-08-01', 180.00, '2023-08-01 10:00:00');

