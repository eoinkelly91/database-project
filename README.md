# Furniture World Database Project

A relational database system designed to transition **Furniture World** from manual, paper-based records to a centralized, normalized database architecture.

---

## Overview

This EERD is based off a furniture store I visited recently which still relies on paper-based records. For the purpose of this project I will call it Furniture World. The store is comprised of different departments including Bedroom, Flooring, Bathroom, Living Room and Kitchen. Each department has a showroom that showcases the stock inside it. Every piece of stock has an ID, name, description, colour, brand, size, stock quantity, warehouse location, price and discount.  

The Flooring and Bathroom departments are not listed as furniture like the other departments but share the attributes of the other stock. All the current stock is stored in a warehouse beside the store. There is another business operating inside the store that sells blinds. There are different variations of blinds available these include Venetian, Wood and Roller blinds. These blinds are made to order according to the customers specifications. The blinds clerk contacts an external manufacturer to produce the blind and return it to the store. Right now, they only work with one manufacturer and all the samples come from them. 

The store is made up of several different employees. There is a store manager who oversees the entire store. Clerks handle the day-to-day transactions with customers, there are clerks for both stores. A clerk can be responsible for either the main store or blind section of the store. A customer places an order with either clerk and that order will contain the stock required. The blind manufacturer receives a specification from the blind clerk and only then can start working on the product. There is a maintenance employee who oversees the storage of all stock items in the warehouse. There is a delivery driver that delivers products from the store to customers. Every employee has an ID, first name, last name, salary and role. 

---

## Entity-Relationship Diagram

![Furniture World EER Diagram](docs/diagrams/database_EERD.png)

# To Do

- Work on the delivery to customer many to many relationship.
- Implement Order Item table