# Furniture World Database Architecture

## 1. Domain & Business Overview
Furniture World is a multi-department retail store transitioning from paper-based tracking to an automated relational database. The core business encompasses:
* **Departmental Showrooms & Inventory:** Covering Furniture (Bedroom, Living Room, Kitchen), Flooring, and Bathroom.
* **On-Site & External Inventory:** Stock housed in an adjacent warehouse facility with replenishment through external suppliers.
* **Specialized Business Unit (Blinds Store):** An integrated concession selling custom, made-to-order blinds (Venetian, Wood, Roller) through an exclusive external manufacturer.
* **Staffing & Operations:** Segregated roles for Store Clerks, Blinds Clerks, Store Management, Facility/Warehouse Maintenance, and Delivery Logistics.

---

## 2. Modeling Standards & Conventions
* **Naming Notation:** Strict `snake_case` for all table names and attribute identifiers.
* **Singular Table Entities:** Primary tables use singular forms (e.g., `stock`, `employee`, `department`) aligned with relational standards.
* **Primary Key Convention:** Natural keys from the EER diagram are mapped cleanly (e.g., `store_id`, `department_id`, `stock_id`, `employee_id`).
* **Foreign Key Convention:** Follows `<referenced_table>_id` format (e.g., `department_id`, `customer_id`).
* **Audit & Monetary Types:**
  * Currencies/Prices: `DECIMAL(10, 2)` (strictly avoiding floating-point rounding issues).
  * Discounts: `DECIMAL(5, 2)` representing percentage or monetary deduction.
  * Timestamps: `TIMESTAMP WITH TIME ZONE` (UTC) for transaction and delivery tracking.

---

## 3. Generalization / Specialization Hierarchies (EER Mapping)

### 3.1 Stock Specialization (`stock`)
The supertype entity `stock` defines common stock-keeping attributes:
* Attributes: `stock_id` (PK), `stock_name`, `description`, `colour`, `brand`, `size`, `stock_quantity`, `location`, `price`, `discount`.

It utilizes a disjoint (`d`) specialization partition into four primary categories:
1. **`furniture`:**
   * Discriminator: `furniture_type` (`'B'` = Bedroom, `'L'` = Living Room, `'K'` = Kitchen).
   * Further specialized subtype: `kitchen` links to `countertop` which defines specific `material`.
2. **`flooring`:**
   * Attribute: `floor_type`, `material`.
3. **`bathroom`:**
   * Specialized subtype: `bath`, which defines `tap` specifications.
4. **`blinds`:**
   * Specialization: `blind_type` (Venetian, Wood, Roller) with customer-specified custom dimensions.

*Relational Mapping Strategy:* **Table-per-Type (TPT)** or **Single-Table Inheritance (STI)** with sparse columns and check constraints. For standard SQL DDL, subtype tables sharing the base `stock_id` as both primary key and foreign key (`stock_id REFERENCES stock(stock_id)`) are recommended for clean normalization and domain enforcement.

### 3.2 Employee Specialization (`employee`)
The supertype entity `employee` captures common personnel details:
* Attributes: `employee_id` (PK), `first_name`, `last_name`, `salary`, `role`.

It branches into disjoint (`d`) subtypes:
* **`manager`:** Oversees both the Main Store and Blinds Store.
* **`maintenance`:** Maintains the warehouse and facility storage.
* **`delivery_driver`:** Executes customer fulfillment.
* **`clerk`:**
  * Further specialized by a disjoint (`d`) constraint into **`store_clerk`** (handles Main Store showroom sales) or **`blinds_clerk`** (manages bespoke blind orders). A clerk cannot be assigned to both units.

---

## 4. Key Relationships & Business Rules

| Relationship | Entities Involved | Cardinality | Business Rule / Constraint |
| :--- | :--- | :--- | :--- |
| **HAS (Store-Department)** | `furniture_world` $\leftrightarrow$ `department` | 1 to Many ($1:N$) | The store contains multiple distinct showroom departments. |
| **HAS (Store-Warehouse)** | `furniture_world` $\leftrightarrow$ `warehouse` | 1 to 1 ($1:1$) | A single central warehouse facility operates beside the main store. |
| **SHOWCASES** | `department` $\leftrightarrow$ `stock` | 1 to Many ($1:N$) | Each department showroom showcases inventory items belonging to its catalog. |
| **MAINTAINS** | `maintenance` $\leftrightarrow$ `warehouse` | Many to 1 ($N:1$) | Maintenance personnel oversee warehouse storage and structural upkeep. |
| **ORDERS BLIND (Customer)** | `customer` $\leftrightarrow$ `blinds_clerk` | Many to 1 ($N:1$) | Customers place bespoke blind specifications directly with a dedicated Blinds Clerk. |
| **ORDERS BLIND (Mfr)** | `blinds_clerk` $\leftrightarrow$ `blind_manufacturer` | Many to 1 ($N:1$) | The Blinds Clerk transmits order specifications to the external single manufacturer. |
| **PRODUCES** | `blind_manufacturer` $\leftrightarrow$ `blinds` | 1 to Many ($1:N$) | The manufacturer fabricates the requested made-to-order blind. |
| **DELIVERS TO** | `delivery_driver` $\leftrightarrow$ `customer` | Many to Many ($M:N$) | Drivers fulfill customer shipments once contact information is released by a Clerk. |

---

## 5. Integrity & Relational Constraints
* **Clerk Role Mutual Exclusivity:** Enforced via `CHECK (clerk_type IN ('STORE', 'BLINDS'))` to guarantee a clerk cannot serve both businesses simultaneously.
* **Stock Quantity & Safety Stock:** `stock_quantity >= 0`. When `stock_quantity = 0`, reorder flags trigger external supplier purchasing.
* **Bespoke Order Workflow:** Blinds records require an associated specification sheet before a production order ID can be dispatched to the external manufacturer.