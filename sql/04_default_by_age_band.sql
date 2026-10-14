-- Q) Does age effect default rates
USE home_credit;
SELECT CASE 
			WHEN ABS(DAYS_BIRTH/365) < 25 THEN "1. Under 25" 
            WHEN ABS(DAYS_BIRTH/365) < 35 THEN "2. 25 - 34"
			WHEN ABS(DAYS_BIRTH/365) < 45 THEN "3. 35 - 44"
            WHEN ABS(DAYS_BIRTH/365) < 55 THEN "4. 45 - 54"
            WHEN ABS(DAYS_BIRTH/365) < 65 THEN "5. 55 - 64"
            ELSE "6. 65 and Over"
	END AS Age_band,
    COUNT(*) AS applications,
    SUM(TARGET) AS defaults,
	ROUND(100*AVG(TARGET),2) AS default_rate_pct
    
FROM application_train
GROUP BY Age_band
ORDER BY Age_band ASC;
