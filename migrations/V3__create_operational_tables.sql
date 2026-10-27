-- V3: Operational Tables for Many-to-Many Relationships

-- 1. Orders Stock: Customer orders Stock from any Clerk (Store or Blinds)
CREATE TABLE customer_stock_orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    clerk_id INT NOT NULL,
    stock_id INT NOT NULL,
    CONSTRAINT fk_cso_customer 
        FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_cso_clerk 
        FOREIGN KEY (clerk_id) REFERENCES clerk(employee_id) ON DELETE CASCADE,
    CONSTRAINT fk_cso_stock 
        FOREIGN KEY (stock_id) REFERENCES stock(stock_id) ON DELETE CASCADE
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