-- V3: Many-to-Many Relationship Tables

-- 1. Customer Orders Blind from Blinds Clerk (M:N)
CREATE TABLE customer_blind_orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    clerk_id INT NOT NULL,
    blind_id INT NOT NULL,
    CONSTRAINT fk_cbo_customer 
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_cbo_clerk 
        FOREIGN KEY (clerk_id) REFERENCES blinds_clerk(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_cbo_blind 
        FOREIGN KEY (blind_id) REFERENCES blinds(stock_id) ON DELETE CASCADE
);

-- 2. Delivery Driver Delivers to Customer (M:N)
CREATE TABLE customer_deliveries (
    delivery_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    driver_id INT NOT NULL,
    customer_id INT NOT NULL,
    CONSTRAINT fk_cd_driver 
        FOREIGN KEY (driver_id) REFERENCES delivery_driver(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_cd_customer 
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);