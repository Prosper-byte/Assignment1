---SQL Data Types (cast)---

SELECT * 
FROM tutorial.crunchbase_companies_clean_date

SELECT funding_total_usd :: varchar, 
       CAST( founded_at_clean as varchar)
FROM tutorial.crunchbase_companies_clean_date

---------------Date Format--------------
-- Interval function
SELECT companies.permalink,
       companies.founded_at_clean,
       companies.founded_at_clean::timestamp +
         INTERVAL '1 week' AS plus_one_week
  FROM tutorial.crunchbase_companies_clean_date companies
 WHERE founded_at_clean IS NOT NULL
 
 --now()
 SELECT permalink,
       founded_at_clean,
       NOW() - founded_at_clean::timestamp AS founded_time_ago
  FROM tutorial.crunchbase_companies_clean_date companies
 WHERE founded_at_clean IS NOT NULL
 
--number of companies acquired within 3, 5 and 10 years of being founded
 SELECT c.category_code,
        COUNT(CASE WHEN a.acquired_at_cleaned <= c.founded_at_clean::timestamp + INTERVAL '3 YEARS' 
              THEN 1 ELSE Null END) as "acquired within 3 years",
        COUNT(CASE WHEN a.acquired_at_cleaned <= c.founded_at_clean::timestamp + INTERVAL '5 YEARS' 
              THEN 1 ELSE null END ) as "acquired within 5 years",
        COUNT (CASE WHEN a.acquired_at_cleaned <= c.founded_at_clean::timestamp + INTERVAL '10 Years'
               THEN 1 ELSE null END) as "acquired within 10 years",
        count(1)
FROM tutorial.crunchbase_companies_clean_date c
     JOIN tutorial.crunchbase_acquisitions_clean_date a
     ON a.company_permalink = c.permalink
WHERE founded_at_clean IS NOT NULL
GROUP BY category_code
ORDER BY 4 desc

--------------String functions to clean data----------
--left,right,length
SELECT incidnt_num, date,
LEFT(date, 10) AS cleaned_date,
RIGHT(date, LENGTH(date) - 11) AS cleaned_time
FROM tutorial.sf_crime_incidents_2014_01

--trim (takes 3 arguments: leading, trailing or both + specify characters to be trimmed + text to be trimmed using from )  
SELECT location, TRIM(both '()' FROM location)
FROM tutorial.sf_crime_incidents_2014_01

---position or strpos achieve the same results---
SELECT incidnt_num, descript,
         POSITION('A' IN descript) AS "Position of A"   --position function is case-sensitive
FROM tutorial.sf_crime_incidents_2014_01

SELECT incidnt_num, descript,
	   STRPOS(descript, 'A') AS "Position of A"     -- strpos function is case-sensitive
  FROM tutorial.sf_crime_incidents_2014_01
  
--syntax for substr: substr(string, starting character position, # of characters)----
SELECT incidnt_num,, date,
       SUBSTR(date, 7, 4) as year
FROM tutorial.sf_crime_incidents_2014_01

---query that seperates a field into seprate fields- Ex: (37.709, -122.412) inot 37.709 and -122.412
SELECT location,
       TRIM(leading '(' FROM LEFT(location, POSITION(',' IN location) - 1)) AS lattitude,
       TRIM(trailing ')' FROM RIGHT(location, LENGTH(location) - POSITION(',' IN location) ) ) AS longitude
FROM tutorial.sf_crime_incidents_2014_01

---concatenate
 SELECT CONCAT('(', lat, ', ', lon, ')') AS concat_location,  location
 FROM tutorial.sf_crime_incidents_2014_01
 
 ---concatenate + date
SELECT incidnt_num, date,
		 SUBSTR(date, 7, 4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date, 4, 2) AS cleaned_date
FROM tutorial.sf_crime_incidents_2014_01

--query that returns the category field, but with the first letter capitalised and the rest of the letters in lower case
--equivalent to Excel function proper
SELECT incidnt_num,  category,
       UPPER(LEFT(category, 1)) || LOWER(RIGHT(category, LENGTH(category) - 1)) AS category_cleaned
  FROM tutorial.sf_crime_incidents_2014_01

---query that counts the number of incidents reported by week. Cast the week as a date to get rid of the hours/minutes/seconds.  
SELECT DATE_TRUNC('week', cleaned_date)::date AS week_beginning,
       COUNT(*) AS incidents
FROM tutorial.sf_crime_incidents_cleandate
GROUP BY 1

---a query that shows exactly how long ago each indicent was reported. Assume that the dataset is in Pacific Standard Time (UTC - 8).
ORDER BY 1
SELECT incidnt_num,
       cleaned_date,
       NOW() AT TIME ZONE 'PST' AS now,
       NOW() AT TIME ZONE 'PST' - cleaned_date AS time_ago 
FROM tutorial.sf_crime_incidents_cleandate

--Coalesce to replace the null values
SELECT incidnt_num,
       descript,
COALESCE(descript, 'No Description Yet')
FROM tutorial.sf_crime_incidents_cleandate
ORDER BY descript DESC

---------------------subqueries---------
 SELECT sub.*
      FROM (
            SELECT *
              FROM tutorial.sf_crime_incidents_2014_01
             WHERE descript = 'WARRANT ARREST'
           ) sub
     WHERE sub.resolution = 'NONE'

SELECT sub.category,
       AVG(sub.incidents) AS avg_incidents_per_month
  FROM (
        SELECT EXTRACT('month' FROM cleaned_date) AS month,
               category,
               COUNT(1) AS incidents
          FROM tutorial.sf_crime_incidents_cleandate
         GROUP BY 1,2
       ) sub
 GROUP BY 1
 
 --a query that displays all rows from the three categories with the fewest incidents reported
 SELECT incidents.*,
       sub.count AS total_incidents_in_category
  FROM tutorial.sf_crime_incidents_2014_01 incidents
  JOIN (
        SELECT category,
               COUNT(*) AS count
          FROM tutorial.sf_crime_incidents_2014_01
         GROUP BY 1
         ORDER BY 2
         LIMIT 3
       ) sub
    ON sub.category = incidents.category
    
--a query that counts the number of companies founded and acquired by quarter starting in Q1 2012. Create the aggregations in two separate queries, then join them.
 SELECT COALESCE(companies.quarter, acquisitions.quarter) AS quarter,
           companies.companies_founded,
           acquisitions.companies_acquired
      FROM (
            SELECT founded_quarter AS quarter,
                   COUNT(permalink) AS companies_founded
              FROM tutorial.crunchbase_companies
             WHERE founded_year >= 2012
             GROUP BY 1
           ) companies
      
      LEFT JOIN (
            SELECT acquired_quarter AS quarter,
                   COUNT(DISTINCT company_permalink) AS companies_acquired
              FROM tutorial.crunchbase_acquisitions
             WHERE acquired_year >= 2012
             GROUP BY 1
           ) acquisitions
        
        ON companies.quarter = acquisitions.quarter
     ORDER BY 1
     
     --a query that ranks investors from the combined dataset above by the total number of investments they have made.
     SELECT investor_name,
       COUNT(*) AS investments
  FROM (
        SELECT *
          FROM tutorial.crunchbase_investments_part1
         
         UNION ALL
        
         SELECT *
           FROM tutorial.crunchbase_investments_part2
       ) sub
 GROUP BY 1
 ORDER BY 2 DESC
 
 -- a query that does the same thing as in the previous problem, except only for companies that are still operating. Hint: operating status is in tutorial.crunchbase_companies.
 SELECT investments.investor_name,
       COUNT(investments.*) AS investments
  FROM tutorial.crunchbase_companies companies
  JOIN (
        SELECT *
          FROM tutorial.crunchbase_investments_part1
         
         UNION ALL
        
         SELECT *
           FROM tutorial.crunchbase_investments_part2
       ) investments
    ON investments.company_permalink = companies.permalink
 WHERE companies.status = 'operating'
 GROUP BY 1
 ORDER BY 2 DESC
 
 --------------------------------windows functions----------------------------------
 --shows the duration of each ride as a percentage of the total time accrued by riders from each start_terminal
 SELECT start_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER (PARTITION BY start_terminal) AS start_terminal_sum,
       (duration_seconds/SUM(duration_seconds) OVER (PARTITION BY start_terminal))*100 AS pct_of_total_time
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'
 ORDER BY 1, 4 DESC
 
 --a query that shows a running total of the duration of bike rides grouped by end_terminal, and with ride duration sorted in descending order.
SELECT end_terminal,
       duration_seconds,
       SUM(duration_seconds) OVER
         (PARTITION BY end_terminal ORDER BY duration_seconds DESC)
         AS running_total
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'
 
 --a query that shows the 5 longest rides from each starting terminal, ordered by terminal, and longest to shortest rides within each terminal. Limit to rides that occurred before Jan. 8, 2012.
 SELECT *
  FROM (
        SELECT start_terminal,
               start_time,
               duration_seconds AS trip_time,
               RANK() OVER (PARTITION BY start_terminal ORDER BY duration_seconds DESC) AS rank
          FROM tutorial.dc_bikeshare_q1_2012
         WHERE start_time < '2012-01-08'
               ) sub
 WHERE sub.rank <= 5

--a query that shows only the duration of the trip and the percentile into which that duration falls (across the entire dataset—not partitioned by terminal).
SELECT duration_seconds,
       NTILE(100) OVER (ORDER BY duration_seconds)
         AS percentile
  FROM tutorial.dc_bikeshare_q1_2012
 WHERE start_time < '2012-01-08'
 ORDER BY 1 DESC
 
