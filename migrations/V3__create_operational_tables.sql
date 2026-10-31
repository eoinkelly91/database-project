-- V3: Associative Entities and Many-to-Many Relationships

-- 1. ORDER (Associative entity bridging Stock, Clerk, Customer)
CREATE TABLE customer_order (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    stock_id INT NOT NULL,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT fk_order_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_clerk 
        FOREIGN KEY (employee_id) REFERENCES clerk(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_order_customer 
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

-- 2. SPECIFICATION (Associative entity bridging Blinds Clerk and Blind Manufacturer)
CREATE TABLE specification (
    spec_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    CONSTRAINT fk_spec_blinds_clerk 
        FOREIGN KEY (employee_id) REFERENCES blinds_clerk(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_spec_manufacturer 
        FOREIGN KEY (manufacturer_id) REFERENCES blind_manufacturer(manufacturer_id) ON DELETE CASCADE
);

-- 3. DELIVERS ORDER (Delivery Driver to Customer)
CREATE TABLE delivery_driver_delivers_order (
    driver_id INT NOT NULL,
    customer_id INT NOT NULL,
    PRIMARY KEY (driver_id, customer_id),
    CONSTRAINT fk_ddo_driver 
        FOREIGN KEY (driver_id) REFERENCES delivery_driver(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_ddo_customer 
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);