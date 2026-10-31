# Furniture World - System Architecture & Database Design

## 1. Domain Overview
Furniture World operates a physical retail store comprising multiple departments (Bedroom, Flooring, Bathroom, Living Room, Kitchen) and an on-site warehouse. In addition, an independent made-to-order Blinds business operates inside the store, coordinating with a single external manufacturer.

## 2. Modeling Conventions & Database Standards
- **Identifiers:** Every entity has an explicit primary key matching the EER diagram (`store_id`, `department_id`, `warehouse_id`, `stock_id`, `employee_id`, `customer_id`, `manufacturer_id`, `order_id`, `spec_id`).
- **Case Convention:** Standard `snake_case` is applied across all table and column names.
- **Specialization/Generalization Mapping:** Table-per-Type (TPT) is utilized to enforce relational integrity for subtype hierarchies (Employee, Stock, Furniture, Flooring, Bathroom, Blinds).
- **Associative Entities:** Operational relationships with specific transaction identifiers (`ORDER` and `SPECIFICATION`) are modeled as dedicated relational bridge tables.

## 3. Specialization Hierarchies (Disjoint `d`)
- **Employee Hierarchy:**
  - Supertype: `employee` (`employee_id`, `first_name`, `last_name`, `salary`, `role`).
  - Subtypes: `maintenance`, `delivery_driver`, `manager`, `clerk`.
  - Clerk Subtypes: Disjoint categorization into `store_clerk` and `blinds_clerk` based on `clerk_type`.
- **Stock Hierarchy:**
  - Supertype: `stock` (`stock_id`, `department_id`, `warehouse_id`, `stock_name`, `size`, `colour`, `brand`, `price`, `discount`, `quantity`, `warehouse_location`).
  - Subtypes: `furniture`, `flooring`, `bathroom`, `blinds`.
- **Furniture Subtypes:**
  - Disjoint discriminator `furniture_type`: `'B'` (Bedroom), `'L'` (Living Room), `'K'` (Kitchen).
  - Subtypes: `bedroom`, `living_room`, `kitchen`.
- **Blinds Subtype:**
  - Specialized attributes: `blind_type`, `specification`, `manufacturer_id`.

## 4. Cardinality & Relationship Constraints
- **Store to Warehouse:** One-to-Many (`1:N`). Furniture World has one or many warehouses.
- **Store to Department:** One-to-Many (`1:N`).
- **Manager to Store:** Many-to-One (`N:1`). Manager oversees store.
- **Department to Stock:** One-to-Many (`1:N`). Departments showcase stock.
- **Warehouse to Stock:** One-to-Many (`1:N`). Warehouse stores stock.
- **Warehouse to Maintenance:** One-to-Many (`1:N`). Warehouse maintained by maintenance employees.
- **Customer, Stock, and Clerk Interaction:** Many-to-Many (`M:N`) transaction resolved via associative entity `customer_order` (`order_id`, `stock_id`, `employee_id`, `customer_id`).
- **Blinds Clerk to Blind Manufacturer:** Resolved via associative entity `specification` (`spec_id`, `employee_id`, `manufacturer_id`).
- **Blind Manufacturer to Blinds:** One-to-Many (`1:N`). Blind manufacturer produces blinds.
- **Delivery Driver to Customer:** Many-to-Many (`M:N`). Resolved via `delivery_driver_delivers_order` (`driver_id`, `customer_id`).