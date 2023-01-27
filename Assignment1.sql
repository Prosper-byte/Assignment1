----SUM----
SELECT SUM(open)/COUNT(open) as "Average Open Price"
  FROM tutorial.aapl_historical_stock_price

-----Average----
SELECT AVG(open) as "Average Open Price"
FROM tutorial.aapl_historical_stock_price

----Case-----
SELECT player_name, state,
CASE WHEN state = 'CA' THEN 'yes'
ELSE NULL END AS From_California
FROM benn.college_football_players
ORDER BY 3

---Join---
SELECT *
FROM benn.college_football_players

SELECT *
FROM benn.college_football_teams

SELECT COUNT(*)
FROM benn.college_football_players

SELECT COUNT(1)
FROM benn.college_football_teams

SELECT p.school_name, p.player_name, p.position, p.weight
FROM benn.college_football_players p 
WHERE state = 'GA'
ORDER BY weight desc

SELECT *
FROM benn.college_football_players p
JOIN benn.college_football_teams t
ON t.school_name = p.school_name

---only column from player table    
SELECT p.*
FROM benn.college_football_players p
JOIN benn.college_football_teams t
ON t.school_name = p.school_name

SELECT t.conference, AVG(p.weight)
FROM benn.college_football_players p
JOIN benn.college_football_teams t
ON t.school_name = p.school_name
GROUP BY conference

---Inner_Join
SELECT p.player_name, p.school_name, t.conference
FROM benn.college_football_players p
JOIN benn.college_football_teams t
ON p.school_name = t.school_name
WHERE t.division = 'FBS (Division I-A Teams)'

----left_join vs Inner_join---
SELECT COUNT(c.*), COUNT(a.*)
FROM tutorial.crunchbase_companies c
INNER JOIN tutorial.crunchbase_acquisitions a
ON c.permalink = a.company_permalink

SELECT COUNT(c.*), COUNT(a.*)
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
ON c.permalink = a.company_permalink

SELECT COUNT(DISTINCT c.permalink), COUNT(DISTINCT a.company_permalink) 
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
ON c.permalink = a.company_permalink
WHERE c.state_code IS NOT NULL
ORDER BY 2 desc

SELECT c.state_code, 
      COUNT(DISTINCT c.permalink) as unique_companies, 
      COUNT(DISTINCT a.company_permalink) as unique_companies_acquired
FROM tutorial.crunchbase_companies c
LEFT JOIN tutorial.crunchbase_acquisitions a
ON c.permalink = a.company_permalink
WHERE c.state_code IS NOT NULL
GROUP BY 1
ORDER BY 3 desc

---Join on multiple keys and right_join vs outer join-------------
SELECT c.permalink,
       c.name,
       i.company_name,
       i.company_permalink
  FROM tutorial.crunchbase_companies c
  RIGHT JOIN tutorial.crunchbase_investments_part1 i
    ON c.permalink = i.company_permalink
   AND c.name = i.company_name

 SELECT c.permalink,
       c.name,
       i.company_name,
       i.company_permalink
  FROM tutorial.crunchbase_companies c
 RIGHT JOIN tutorial.crunchbase_investments_part1 i
    ON c.permalink = i.company_permalink
   AND c.name = i.company_name
