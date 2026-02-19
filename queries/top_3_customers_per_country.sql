/* Query: Top Customers per Country by Total Spending

Description:
Returns the top 3 customers in each billing country ranked by total amount spent.
If multiple customers tie for a rank, all tied customers are included.

Logic:
1. Join customers with invoices
2. Aggregate total spending per customer per country
3. Rank customers within each country using DENSE_RANK()
4. Filter to top 3 ranks

Key Concepts Used:
- CTEs
- Window Functions
- DENSE_RANK()
- Aggregations
- PARTITION BY

Note:
Country refers to Invoice.BillingCountry 
*/


with format1 as (select c.customerid,concat(c.firstname,' ',c.lastname) as fullname,i.billingcountry as country,i.total, sum(i.total) over(partition by i.billingcountry) as country_revenue from customer c 
inner join invoice i 
on i.customerid = c.customerid),
format2 as(
select customerid,fullname,country,country_revenue, sum(total) as totalspent from format1 group by customerid,fullname,country,country_revenue),
format3 as(
select *, dense_rank() over(partition by country order by totalspent desc) rn from format2) 

select fullname, country, totalspent, rn as countriesrank from format3 where rn <= 3 order by country 
