-- V1: Core Infrastructure and External Base Entities

-- 1. Furniture World Store
CREATE TABLE furniture_world (
    store_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL
);

-- 2. Department
CREATE TABLE department (
    department_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    CONSTRAINT fk_department_store 
        FOREIGN KEY (store_id) REFERENCES furniture_world(store_id) ON DELETE CASCADE
);

-- 3. Warehouse
CREATE TABLE warehouse (
    warehouse_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_id INT NOT NULL,
    CONSTRAINT fk_warehouse_store 
        FOREIGN KEY (store_id) REFERENCES furniture_world(store_id) ON DELETE CASCADE
);

-- 4. Employee Supertype
CREATE TABLE employee (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    role VARCHAR(30) NOT NULL
);

-- 5. Customer
CREATE TABLE customer (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

-- 6. Blind Manufacturer
CREATE TABLE blind_manufacturer (
    manufacturer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
);

-- 7. Stock Supertype
CREATE TABLE stock (
    stock_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    stock_name VARCHAR(100) NOT NULL,
    size VARCHAR(50),
    colour VARCHAR(30),
    brand VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(5, 2),
    quantity INT NOT NULL,
    warehouse_location VARCHAR(50),
    CONSTRAINT fk_stock_department 
        FOREIGN KEY (department_id) REFERENCES department(department_id),
    CONSTRAINT fk_stock_warehouse 
        FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id)
);