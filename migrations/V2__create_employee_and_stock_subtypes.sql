-- V2: Subtype Hierarchies for Employees and Stock

-- ==========================================================
-- Employee Subtypes
-- ==========================================================

CREATE TABLE manager (
    employee_id INT PRIMARY KEY,
    CONSTRAINT fk_manager_employee 
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE delivery_driver (
    employee_id INT PRIMARY KEY,
    CONSTRAINT fk_driver_employee 
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE maintenance (
    employee_id INT PRIMARY KEY,
    warehouse_id INT NOT NULL,
    CONSTRAINT fk_maintenance_employee 
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_maintenance_warehouse 
        FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);

CREATE TABLE clerk (
    employee_id INT PRIMARY KEY,
    clerk_type VARCHAR(20) NOT NULL CHECK (clerk_type IN ('STORE', 'BLINDS')),
    CONSTRAINT fk_clerk_employee 
        FOREIGN KEY (employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE store_clerk (
    employee_id INT PRIMARY KEY,
    CONSTRAINT fk_store_clerk 
        FOREIGN KEY (employee_id) REFERENCES clerk(employee_id) ON DELETE CASCADE
);

-- Blinds clerk places specs with blind manufacturer
CREATE TABLE blinds_clerk (
    employee_id INT PRIMARY KEY,
    manufacturer_id INT NOT NULL,
    CONSTRAINT fk_blinds_clerk 
        FOREIGN KEY (employee_id) REFERENCES clerk(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_blinds_clerk_manufacturer 
        FOREIGN KEY (manufacturer_id) REFERENCES blind_manufacturer(manufacturer_id)
);

-- ==========================================================
-- Stock Subtypes
-- ==========================================================

CREATE TABLE furniture (
    stock_id INT PRIMARY KEY,
    furniture_type CHAR(1) NOT NULL CHECK (furniture_type IN ('B', 'L', 'K')),
    CONSTRAINT fk_furniture_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE bedroom (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_bedroom_furniture 
        FOREIGN KEY (stock_id) REFERENCES furniture(stock_id) ON DELETE CASCADE
);

CREATE TABLE living_room (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_living_room_furniture 
        FOREIGN KEY (stock_id) REFERENCES furniture(stock_id) ON DELETE CASCADE
);

CREATE TABLE kitchen (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_kitchen_furniture 
        FOREIGN KEY (stock_id) REFERENCES furniture(stock_id) ON DELETE CASCADE
);

CREATE TABLE countertop (
    stock_id INT PRIMARY KEY,
    material VARCHAR(50) NOT NULL,
    CONSTRAINT fk_countertop_kitchen 
        FOREIGN KEY (stock_id) REFERENCES kitchen(stock_id) ON DELETE CASCADE
);

CREATE TABLE flooring (
    stock_id INT PRIMARY KEY,
    floor_type VARCHAR(50) NOT NULL,
    CONSTRAINT fk_flooring_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE bathroom (
    stock_id INT PRIMARY KEY,
    CONSTRAINT fk_bathroom_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
);

CREATE TABLE bath (
    stock_id INT PRIMARY KEY,
    tap VARCHAR(50),
    CONSTRAINT fk_bath_bathroom 
        FOREIGN KEY (stock_id) REFERENCES bathroom(stock_id) ON DELETE CASCADE
);

CREATE TABLE blinds (
    stock_id INT PRIMARY KEY,
    blind_type VARCHAR(30) NOT NULL,
    manufacturer_id INT NOT NULL,
    CONSTRAINT fk_blinds_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE,
    CONSTRAINT fk_blinds_manufacturer 
        FOREIGN KEY (manufacturer_id) REFERENCES blind_manufacturer(manufacturer_id)
);