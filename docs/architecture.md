# Furniture World - System Architecture & Database Design

## 1. Domain Overview
Furniture World operates a physical retail store comprising multiple departments (Bedroom, Flooring, Bathroom, Living Room, Kitchen) and an on-site warehouse. In addition, an independent made-to-order Blinds business operates inside the store, coordinating with a single external manufacturer.

## 2. Modeling Conventions & Database Standards
* **Identifiers:** Every entity has an explicit primary key matching the EER diagram (e.g., `store_id`, `department_id`, `stock_id`, `employee_id`, `customer_id`, `manufacturer_id`).
* **Case Convention:** Standard `snake_case` is applied across all table and column names.
* **Specialization/Generalization Mapping:** Table-per-Type (TPT) is utilized to enforce relational integrity for subtype hierarchies (Employee, Stock, Furniture, Flooring, Bathroom, Blinds).

## 3. Specialization Hierarchies (Disjoint `d`)
* **Employee:**
  * Supertype: `employees` (`employee_id`, `first_name`, `last_name`, `salary`, `role`).
  * Subtypes: `maintenance`, `delivery_drivers`, `managers`, `clerks`.
  * Clerk Subtypes: Disjoint categorization into `store_clerks` and `blinds_clerks`.
* **Stock:**
  * Supertype: `stock` (`stock_id`, `stock_name`, `description`, `size`, `colour`, `brand`, `price`, `discount`, `stock_quantity`, `location`, `warehouse_details`).
  * Subtypes: `furniture`, `flooring` (`floor_type`), `bathroom`, `blinds` (`blind_type`).
* **Furniture Subtypes:**
  * Disjoint discriminator `furniture_type`: `'B'` (Bedroom), `'L'` (Living Room), `'K'` (Kitchen).
  * Kitchen contains `countertop` with attribute `material`.
  * Bathroom contains `bath` with attribute `tap`.

## 4. Cardinality & Relationship Constraints
* **Store to Warehouse:** One-to-Many (`1:N`). Furniture World has one or many warehouses.
* **Store to Department:** One-to-Many (`1:N`).
* **Department to Stock:** One-to-Many (`1:N`). Departments showcase stock.
* **Warehouse to Maintenance:** One-to-Many (`1:N`). Maintained by maintenance employees.
* **Blinds Clerk to Blind Manufacturer:** Many-to-One (`N:1`). Blinds clerks place specs with only one blind manufacturer.
* **Manufacturer to Blinds:** One-to-Many (`1:N`). Manufacturer produces blinds.
* **Delivery Driver to Customer:** Many-to-Many (`M:N`). Resolved via `customer_deliveries`.
* **Customer to Blinds Clerk:** Many-to-Many (`M:N`). Customers order blinds from blinds clerks, resolved via `customer_blind_orders`.