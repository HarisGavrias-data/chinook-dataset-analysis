/*
Query Name: Top Customer per Genre

Description:
Returns the highest-spending customer within each music genre based on total purchase amount.
If multiple customers tie for the highest spending in a genre, all tied customers are included.

Methodology:
1. Join customers, invoices, invoice lines, tracks, and genres
2. Calculate total spending per customer per genre
3. Rank customers within each genre using a window function
4. Filter results to return only top-ranked customers

Key SQL Concepts Used:
- Multi-table JOINs
- Aggregation (SUM)
- Common Table Expressions (CTEs)
- Window Functions (RANK with PARTITION BY)
- Analytical filtering
*/

with format1 as (select c.customerid,concat(c.firstname,' ',c.lastname) as fullname,sum(il.unitprice*coalesce(il.quantity,0)) as amount ,g.name as genrename,g.genreid
from customer c 
join invoice i on c.customerid = i.customerid
join invoiceline il on i.invoiceid = il.invoiceid
join track t on t.trackid = il.trackid
join genre g on g.genreid = t.genreid 
group by c.customerid,c.firstname,c.lastname,g.genreid,g.name),
format2 as (
select *, rank() over(partition by genrename order by amount desc) as genre_rank from format1)

select genrename,amount,fullname,genre_rank from format2 where genre_rank = 1
order by genrename;
