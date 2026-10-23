-- V1: Core Infrastructure and Base Tables

-- 1. Store Entity
CREATE TABLE stores (
    store_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Warehouse
CREATE TABLE warehouses (
    warehouse_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_id INT NOT NULL,
    location VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_warehouses_store 
        FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE
);

-- 3. Departments
CREATE TABLE departments (
    department_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    store_id INT NOT NULL,
    department_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_departments_store 
        FOREIGN KEY (store_id) REFERENCES stores(store_id) ON DELETE CASCADE
);

-- 4. Base Employee (Supertype)
CREATE TABLE employees (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL CHECK (salary >= 0),
    role VARCHAR(30) NOT NULL CHECK (role IN ('MANAGER', 'CLERK', 'DELIVERY_DRIVER', 'MAINTENANCE')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Base Stock (Supertype)
CREATE TABLE stock (
    stock_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_id INT NOT NULL,
    stock_name VARCHAR(100) NOT NULL,
    description TEXT,
    size VARCHAR(50),
    colour VARCHAR(30),
    brand VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    discount DECIMAL(5, 2) DEFAULT 0.00 CHECK (discount >= 0 AND discount <= 100),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    warehouse_location VARCHAR(50),
    stock_type VARCHAR(20) NOT NULL CHECK (stock_type IN ('FURNITURE', 'FLOORING', 'BATHROOM', 'BLINDS')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_stock_department 
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
);