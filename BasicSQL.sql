--SELECT
SELECT year AS "Year",
       month AS "Month",
       month_name AS "Month Name",
       west AS "West",
       midwest AS "Midwest",
       south AS "South",
       northeast AS "Northeast"
  FROM tutorial.us_housing_units
--LIMIT 
SELECT *
  FROM tutorial.us_housing_units
 LIMIT 15
--comparison operators
SELECT *
  FROM tutorial.us_housing_units
 WHERE south <= 20
 
 --a query that only shows rows for which the month_name starts with the letter "N" or an earlier letter in the alphabet.
 SELECT *
  FROM tutorial.us_housing_units
 WHERE month_name < 'o'
 
 --a query that calculates the sum of all four regions in a separate column.
 SELECT year,
       month,
       west,
       south,
       midwest,
       northeast,
       west + south + midwest +northeast AS usa_total
  FROM tutorial.us_housing_units

--a query that returns all rows for which more units were produced in the West region than in the Midwest and Northeast combined.
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast
  FROM tutorial.us_housing_units
  WHERE west > (midwest + northeast)
  
  --a query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later.
  SELECT year,
       month,
       west/(west + south + midwest + northeast)*100 AS west_pct,
       south/(west + south + midwest + northeast)*100 AS south_pct,
       midwest/(west + south + midwest + northeast)*100 AS midwest_pct,
       northeast/(west + south + midwest + northeast)*100 AS northeast_pct
  FROM tutorial.us_housing_units
 WHERE year >= 2000
 
 
 ----IN-----
 
  SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE group_name IN ('M.C. Hammer', 'Hammer', 'Elvis Presley')
 
 ---------Between-------
 --a query that shows all top 100 songs from January 1, 1985 through December 31, 1990.
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year BETWEEN 1985 AND 1990
 
 -----------Is NULL----------
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE song_name IS NULL
 
 --a query that lists all songs from the 1960s with "love" in the title.
  SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year BETWEEN 1960 AND 1969
   AND song_name ilike '%love%'
 
 ----OR------
--a query that lists all top-100 recordings that feature Dr. Dre before 2001 or after 2009. 
 SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE group_name ILIKE '%dr. dre%'
   AND (year <= 2000 OR year >= 2010)

----------NOT------------
--a query that returns all rows for songs that were on the charts in 2013 and do not contain the letter "a".
SELECT *
      FROM tutorial.billboard_top_100_year_end
     WHERE song_name NOT ILIKE '%a%'
       AND year = 2013
       
--a query that returns all rows from 2012, ordered by song title from Z to A.

SELECT *
  FROM tutorial.billboard_top_100_year_end
 WHERE year = 2012
 ORDER BY song_name DESC