# Chinook Customer Analysis Project

## Overview
This project analyzes customer behavior, revenue trends, and purchasing patterns using the Chinook relational database. The goal is to extract business insights using SQL queries that simulate real-world data analysis tasks.

---

## Dataset
The dataset is the Chinook database, which represents a digital media store with multiple related tables including:

- Customers
- Invoices
- InvoiceItems
- Tracks
- Albums
- Artists
- Genres

This structure allows complex relational queries similar to real company databases.

Download it here:
https://github.com/lerocha/chinook-database

---
## Setup Instructions

1. Create database
   CREATE DATABASE chinook;

2. Import dataset
   mysql -u <username> -p chinook < Chinook_MySql.sql

3. Run queries from the /queries directory
---
## Objectives
The analysis answers business-relevant questions such as:

- Who are the top spending customers?
- Which countries generate the most revenue?
- What genres sell the most?
- What is the average customer purchase value?
- Which customers make repeat purchases?

---

## SQL Skills Demonstrated
- Joins across multiple tables
- Aggregations and grouping
- Subqueries
- Window functions
- Sorting and filtering
- Business metric calculations

---

## Key Insights
- Customer Spending Patterns:
  
A small subset of customers contributes the majority of total revenue, indicating a high-value customer segment.
Average invoice value varies significantly between customers, suggesting different purchasing behaviors.

- Regional Purchasing Trends:
   Top-spending customers differ by country, showing that revenue drivers are geographically segmented.
   Certain countries have multiple top customers tied in spending, indicating competitive markets rather than single dominant buyers.

- Genre Preferences:
   Customer spending varies widely across genres, suggesting strong individual music preferences.
   Some genres have multiple top spenders, indicating shared popularity rather than niche appeal.

- Track Popularity by Region:
   The most purchased track differs across countries, showing regional differences in music taste.
   Track popularity is not globally uniform — local trends strongly influence sales.


---

## Tools Used
- SQL
- Chinook Database

---

## Author
Haris Gavrias — SQL & Python Data Analyst
