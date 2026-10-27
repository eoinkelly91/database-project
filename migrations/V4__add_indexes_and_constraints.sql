-- V4: Foreign Key and Search Indexes

CREATE INDEX idx_warehouse_store_id ON warehouse(store_id);
CREATE INDEX idx_department_store_id ON department(store_id);
CREATE INDEX idx_stock_department_id ON stock(department_id);
CREATE INDEX idx_maintenance_warehouse_id ON maintenance(warehouse_id);
CREATE INDEX idx_clerk_manufacturer_id ON clerk(manufacturer_id);
CREATE INDEX idx_blinds_manufacturer_id ON blinds(manufacturer_id);

CREATE INDEX idx_cbo_customer_id ON customer_blind_orders(customer_id);
CREATE INDEX idx_cbo_clerk_id ON customer_blind_orders(clerk_id);
CREATE INDEX idx_cd_driver_id ON customer_deliveries(driver_id);
CREATE INDEX idx_cd_customer_id ON customer_deliveries(customer_id);