-- V2: Subtype Entities (Employees & Inventory)

-- ==========================================================
-- Employee Subtypes
-- ==========================================================

CREATE TABLE managers (
    employee_id INT PRIMARY KEY,
    CONSTRAINT fk_managers_employee 
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE delivery_drivers (
    employee_id INT PRIMARY KEY,
    license_number VARCHAR(50),
    CONSTRAINT fk_drivers_employee 
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE maintenance_staff (
    employee_id INT PRIMARY KEY,
    warehouse_id INT,
    CONSTRAINT fk_maint_employee 
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_maint_warehouse 
        FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

CREATE TABLE clerks (
    employee_id INT PRIMARY KEY,
    clerk_type VARCHAR(20) NOT NULL CHECK (clerk_type IN ('STORE', 'BLINDS')),
    CONSTRAINT fk_clerks_employee 
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE CASCADE
);

-- ==========================================================
-- Stock Subtypes
-- ==========================================================

-- Furniture Supertype & Subtypes
CREATE TABLE furniture (
    stock_id INT PRIMARY KEY,
    furniture_type CHAR(1) NOT NULL CHECK (furniture_type IN ('B', 'L', 'K')), -- Bedroom, Living Room, Kitchen
    CONSTRAINT fk_furniture_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE bedroom_furniture (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_bedroom_furniture 
        FOREIGN KEY (stock_id) REFERENCES furniture(stock_id) ON DELETE CASCADE
);

CREATE TABLE living_room_furniture (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_living_furniture 
        FOREIGN KEY (stock_id) REFERENCES furniture(stock_id) ON DELETE CASCADE
);

CREATE TABLE kitchen_furniture (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_kitchen_furniture 
        FOREIGN KEY (stock_id) REFERENCES furniture(stock_id) ON DELETE CASCADE
);

CREATE TABLE countertops (
    stock_id INT PRIMARY KEY,
    material VARCHAR(50) NOT NULL,
    CONSTRAINT fk_countertop_kitchen 
        FOREIGN KEY (stock_id) REFERENCES kitchen_furniture(stock_id) ON DELETE CASCADE
);

-- Flooring Subtype
CREATE TABLE flooring (
    stock_id INT PRIMARY KEY,
    floor_type VARCHAR(50) NOT NULL,
    material VARCHAR(50) NOT NULL,
    CONSTRAINT fk_flooring_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

-- Bathroom Subtype
CREATE TABLE bathroom_items (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_bathroom_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE baths (
    stock_id INT PRIMARY KEY,
    tap VARCHAR(50),
    CONSTRAINT fk_baths_bathroom 
        FOREIGN KEY (stock_id) REFERENCES bathroom_items(stock_id) ON DELETE CASCADE
);

-- Blinds Subtype
CREATE TABLE blinds (
    stock_id INT PRIMARY KEY,
    blind_type VARCHAR(30) NOT NULL CHECK (blind_type IN ('Venetian', 'Wood', 'Roller')),
    CONSTRAINT fk_blinds_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);