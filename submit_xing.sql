/* Question 0 */
select
*
from marketing_data limit 2;

/* Question 1: Generate a query to get the
sum of the clicks of the marketing data. */
SELECT SUM(clicks) FROM "marketing_data";

/* Question 2: Generate a query to gather
the sum of revenue by store_location from
the store_revenue table. */
SELECT SUM(revenue), store_location
FROM "store_revenue"
GROUP BY store_location;

/* Question 3: Merge these two datasets so we
can see impressions, clicks, and revenue together
by date and geo. Please ensure all records from
each table are accounted for.
 */
SELECT
 marketing_data.date,
 geo,
 impressions,
 clicks,
 revenue
FROM
 marketing_data
Left JOIN 
store_revenue 
ON
RIGHT(store_revenue.store_location, 2) = marketing_data.geo
AND
store_revenue.date = marketing_data.date

/* Question 4: In your opinion, what is the most
efficient store and why? */

/** In my opinion, I think the most efficient
store would be CA, given that not only it has the most clicks overall, 
but also generate most impression and revenue in general. That is to say, 
the revenue, impression generate from per click is the highest, thus the most efficient.*/

/* Question 5: (Challenge) Generate a query to
rank in order the top 10 revenue producing states */
WITH table_a as
(SELECT
SUM(revenue) as revenue,
store_location
FROM
store_revenue
GROUP BY store_location)
select
  rank() over(order by revenue desc) as rank,
  store_location,
  revenue
from table_a