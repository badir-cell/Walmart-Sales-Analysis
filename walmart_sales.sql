SELECT * FROM walmart.walmart_sales;

-- First checking number of rows
SELECT COUNT(*)
FROM walmart_sales;

-- Checking quantities
SELECT MAX(quantity)
FROM walmart_sales;

-- BUSINESS PROBLEMS
-- Q-1 Find different payment methods,number of transactions and quantity sold

SELECT   payment_method,COUNT(*) as number_of_transactions,SUM(quantity) as quantity_sold
FROM walmart_sales
GROUP BY payment_method;


-- Q-2 Identify higest rated category in each branch and displaying Branch, category and avarage rating

SELECT*
FROM
	(SELECT Branch,category,AVG(rating) as avg_rating,
	RANK()OVER(PARTITION BY Branch ORDER BY AVG(rating) DESC) as rating_rank
	FROM walmart_sales
	GROUP BY Branch,category)AS ranked_data
WHERE rating_rank=1;

-- Q-3 Identify the busiest day for each branch based on number of transactions
-- use date format
SELECT 
    date,
    DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%Y-%m-%d') AS formatted_date
FROM 
    walmart_sales;
    -- list days name
SELECT 
    date,
  DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'),'%W') AS day_name
FROM 
    walmart_sales;
    
    -- number of transictions 
    select*
    from
		(SELECT 
		Branch,
		DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%W') AS day_name,
		COUNT(*) AS transaction_count,RANK()OVER(PARTITION BY Branch ORDER BY COUNT(*) )as rank_rating
	FROM 
		walmart_sales
	GROUP BY 
		Branch,
		day_name) as ranked
        WHERE rank_rating=1;
        
-- Q-4  calculate the total quantity of items sold per payment metod.List payment_method and total_quantity.        
   
   SELECT   payment_method,SUM(quantity) as quantity_sold
FROM walmart_sales
GROUP BY payment_method;

-- Q-5 Determine the average,minimun and maximum rating of category for each city.
-- List the city average_rating,minmum_rating and maximum_rating.

SELECT City,category,
MIN(rating) as min_rating,
MAX(rating) as max_rating,
AVG(rating) as ave_rating
FROM walmart_sales
GROUP BY City,category;

-- Q-6 calculate the total profit for each category  by considering total profit as 
-- (unite price * quantity * profit_margin. List category and total profit and order from highest to lowest profit.

SELECT category,
SUM(Total) as Revenue,
SUM(Total*profit_margin) as Total_profit
FROM walmart_sales
GROUP BY category;

-- Q- 7 Determine the most common payment method for each Branch
-- Display Branch and prefered payment_method

WITH CTE AS
	(SELECT Branch,payment_method,COUNT(*),
	RANK()OVER(PARTITION BY Branch ORDER BY COUNT(*)DESC ) as ranking
	FROM walmart_sales
	GROUP BY Branch,payment_method)
    
    SELECT *
    FROM CTE
    WHERE ranking=1;
    
    -- Q-8 categorize sales in morning, afternoon and evening
    -- Find out each of the shift and number of invioces
    
    SELECT *,time,
    TIME_FORMAT(time,'%H:%i:%s') as converted_time
    FROM walmart_sales;
    
    SELECT Branch,
    CASE 
		WHEN EXTRACT(HOUR FROM(TIME_FORMAT(time,'%H:%i:%s')))< 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM(TIME_FORMAT(time,'%H:%i:%s'))) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END day_time, COUNT(*) as time_count
    FROM walmart_sales
    GROUP BY day_time,Branch
    ORDER BY Branch, day_time;
    
    -- Q-9 Identify 5 branch with highest decrease ratio in revenu 
    -- compare to last year(current year 2022 last year 2024)
    
SELECT 
    *,
     YEAR (DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%Y-%m-%d')) AS formatted_date
FROM 
    walmart_sales;
    
    WITH revenu_2022 AS 
		(SELECT Branch,SUM(Total) as revenu
		FROM walmart_sales
		WHERE YEAR (DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%Y-%m-%d'))=2022
		GROUP BY Branch),
		
      revenu_2023 AS
					(SELECT Branch,SUM(Total) as revenu
					FROM walmart_sales
					WHERE YEAR (DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%Y-%m-%d'))=2023
					GROUP BY Branch)
                    
                    SELECT ls.Branch,ls.revenu as last_year_revenu,
                    cs.revenu as current_year_revenu,
                    ROUND(ls.revenu-cs.revenu/ls.revenu*100,2) as rev_dec_ratio
                    FROM revenu_2022 AS ls 
                    JOIN revenu_2023 AS cs 
                    ON ls.branch=cs.branch
					WHERE ls.revenu  > cs.revenu
                    ORDER BY rev_dec_ratio DESC
                    LIMIT 5
                  