-- V3: External Entities and Transaction Workflows

-- 1. Customers
CREATE TABLE customers (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(30) NOT NULL,
    delivery_address TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. External Blind Manufacturer
CREATE TABLE blind_manufacturers (
    manufacturer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    manufacturer_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(30),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Custom Blinds Orders
CREATE TABLE blind_orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    clerk_id INT NOT NULL,
    manufacturer_id INT NOT NULL,
    blind_type VARCHAR(30) NOT NULL CHECK (blind_type IN ('Venetian', 'Wood', 'Roller')),
    specifications TEXT NOT NULL,
    order_status VARCHAR(30) NOT NULL DEFAULT 'PENDING_MANUFACTURE' 
        CHECK (order_status IN ('PENDING_MANUFACTURE', 'IN_PRODUCTION', 'RECEIVED_AT_STORE', 'DISPATCHED', 'COMPLETED')),
    order_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_blind_orders_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_blind_orders_clerk 
        FOREIGN KEY (clerk_id) REFERENCES clerks(employee_id),
    CONSTRAINT fk_blind_orders_manufacturer 
        FOREIGN KEY (manufacturer_id) REFERENCES blind_manufacturers(manufacturer_id)
);

-- 4. Customer Deliveries
CREATE TABLE deliveries (
    delivery_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL,
    driver_id INT NOT NULL,
    clerk_id INT NOT NULL,
    delivery_status VARCHAR(30) NOT NULL DEFAULT 'SCHEDULED' 
        CHECK (delivery_status IN ('SCHEDULED', 'IN_TRANSIT', 'DELIVERED', 'FAILED')),
    scheduled_date DATE NOT NULL,
    delivery_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_deliveries_customer 
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_deliveries_driver 
        FOREIGN KEY (driver_id) REFERENCES delivery_drivers(employee_id),
    CONSTRAINT fk_deliveries_clerk 
        FOREIGN KEY (clerk_id) REFERENCES clerks(employee_id)
);