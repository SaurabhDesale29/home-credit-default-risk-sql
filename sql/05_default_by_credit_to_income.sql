-- Q) Are prople with more loan amount compared to their salart defaulting more?
-- using null if in income to check if income is zero, if it is zero it will treat it as null

USE home_credit;
SELECT CASE 
			WHEN (AMT_CREDIT/nullif((AMT_INCOME_TOTAL),0)) < 2 THEN "1. Under 2x" 
            WHEN (AMT_CREDIT/AMT_INCOME_TOTAL) < 4 THEN "2. 2x to Under 4x"
            WHEN (AMT_CREDIT/AMT_INCOME_TOTAL) < 6 THEN "3. 4x to Under 6x"
            ELSE "4. 6x and Above"
END AS loan_multiple,
COUNT(*) AS applications,
    SUM(TARGET) AS defaults,
	ROUND(100*AVG(TARGET),2) AS default_rate_pct
    
FROM application_train
GROUP BY loan_multiple
ORDER BY loan_multiple ASC;
