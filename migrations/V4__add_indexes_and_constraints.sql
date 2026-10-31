-- V4: Performance Optimization and Foreign Key Indexes

CREATE INDEX idx_dept_store_id ON department(store_id);
CREATE INDEX idx_warehouse_store_id ON warehouse(store_id);
CREATE INDEX idx_manager_store_id ON manager(store_id);
CREATE INDEX idx_maintenance_warehouse_id ON maintenance(warehouse_id);

CREATE INDEX idx_stock_dept_id ON stock(department_id);
CREATE INDEX idx_stock_warehouse_id ON stock(warehouse_id);
CREATE INDEX idx_blinds_mfg_id ON blinds(manufacturer_id);

CREATE INDEX idx_order_stock_id ON customer_order(stock_id);
CREATE INDEX idx_order_employee_id ON customer_order(employee_id);
CREATE INDEX idx_order_customer_id ON customer_order(customer_id);

CREATE INDEX idx_spec_employee_id ON specification(employee_id);
CREATE INDEX idx_spec_manufacturer_id ON specification(manufacturer_id);

CREATE INDEX idx_ddo_driver_id ON delivery_driver_delivers_order(driver_id);
CREATE INDEX idx_ddo_customer_id ON delivery_driver_delivers_order(customer_id);