/*
Query Name: Top Customers by Country Revenue Contribution

Description:
Identifies the top 3 customers within each country based on their percentage contribution
to total country revenue. This reveals which customers drive the largest share of sales
in each region.

Methodology:
1. Calculate total spending per customer per country
2. Calculate total revenue per country
3. Compute each customer's revenue contribution percentage
4. Rank customers within each country using DENSE_RANK
5. Return top 3 contributors per country

Key Concepts Demonstrated:
- Window Functions
- PARTITION BY
- Revenue contribution analysis
- Multi-level aggregation
- Ranking within groups
- Analytical SQL logic

Business Value:
Helps identify high-value customers in each region, useful for
customer segmentation, loyalty targeting, and regional strategy.
*/
WITH format1 AS (SELECT c.customerid, CONCAT(c.firstname,' ',c.lastname) AS full_name,
i.billingcountry AS country, i.total,
SUM(i.total) OVER (PARTITION BY c.customerid, i.billingcountry) AS customer_revenue,
SUM(i.total) OVER (PARTITION BY i.billingcountry) AS country_revenue
FROM customer c JOIN invoice i ON c.customerid = i.customerid),
format2 AS (SELECT customerid, full_name, country, MAX(customer_revenue) AS customer_revenue,
MAX(country_revenue)  AS country_revenue
FROM format1 GROUP BY customerid, full_name, country),
final_table AS (SELECT *, (100 * customer_revenue / country_revenue) AS contribution_percent_raw,
ROUND((100 * customer_revenue / country_revenue), 2) AS contribution_percent,
DENSE_RANK() OVER ( PARTITION BY country ORDER BY (100 * customer_revenue / country_revenue) DESC) AS ranked_per_country
FROM format2)

SELECT country, full_name, customer_revenue, contribution_percent, ranked_per_country
FROM final_table 
WHERE ranked_per_country <= 3 ORDER BY country, ranked_per_country;
