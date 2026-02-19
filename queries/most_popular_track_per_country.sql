/*
Query Name: Most Popular Track per Country

Description:
Identifies the most frequently purchased track within each country based on total quantity sold.
If multiple tracks share the highest purchase count in a country, all tied tracks are returned.

Methodology:
1. Join tracks, invoices, invoice lines, albums, and artists
2. Aggregate total purchases per track per country
3. Rank tracks within each country using a window function
4. Filter results to return only top-ranked tracks

Key Concepts Demonstrated:
- Multi-table joins
- Aggregation (SUM)
- Common Table Expressions (CTEs)
- Window functions (RANK with PARTITION BY)
- Analytical ranking logic

Notes:
Popularity is defined as purchase frequency, not revenue.
*/

with format1 as (select t.trackid,i.billingcountry,t.name as trackname,ar.name as artistname, sum(il.quantity) as totalpurchases
from track t 
join invoiceline il on t.trackid = il.trackid
join invoice i on i.invoiceid = il.invoiceid
join album al on al.albumid = t.albumid
join artist ar on ar.artistid = al.artistid
group by t.trackid, ar.name, i.billingcountry,t.name),
final_table as(
select billingcountry,trackname,artistname,totalpurchases,rank() over(partition by billingcountry order by totalpurchases desc) as country_rank from format1)

select billingcountry, trackname, artistname, totalpurchases, country_rank from final_table where country_rank = 1;
