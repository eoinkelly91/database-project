-- V4: Performance Optimization and Search Indexes

-- Foreign key indexes
CREATE INDEX idx_stock_department_id ON stock(department_id);
CREATE INDEX idx_stock_stock_type ON stock(stock_type);
CREATE INDEX idx_blind_orders_customer_id ON blind_orders(customer_id);
CREATE INDEX idx_blind_orders_status ON blind_orders(order_status);
CREATE INDEX idx_deliveries_customer_id ON deliveries(customer_id);
CREATE INDEX idx_deliveries_driver_id ON deliveries(driver_id);
CREATE INDEX idx_deliveries_status ON deliveries(delivery_status);

-- Search indexes for inventory queries
CREATE INDEX idx_stock_name ON stock(stock_name);
CREATE INDEX idx_stock_brand ON stock(brand);
CREATE INDEX idx_customers_phone ON customers(phone_number);