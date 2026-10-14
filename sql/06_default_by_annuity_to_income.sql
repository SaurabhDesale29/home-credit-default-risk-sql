-- Q) do borrowers whose instalment is a larger share of their income default more?

USE home_credit;

SELECT CASE WHEN AMT_ANNUITY / NULLIF(AMT_INCOME_TOTAL, 0) IS NULL THEN '0. Annuity missing'
			WHEN AMT_ANNUITY/NULLIF(AMT_INCOME_TOTAL, 0) <0.1 THEN "1. Under 0.1"
			WHEN AMT_ANNUITY/NULLIF(AMT_INCOME_TOTAL, 0) <0.15 THEN "2. 0.1 to Under 0.15"
            WHEN AMT_ANNUITY/NULLIF(AMT_INCOME_TOTAL, 0) <0.2 THEN "3. 0.15 to Under 0.2"
            WHEN AMT_ANNUITY/NULLIF(AMT_INCOME_TOTAL, 0) <0.3 THEN "4. 0.2 to Under 0.3"
            ELSE "5. 0.3 and Above" 
	END AS EMI_bands,
COUNT(*),
SUM(TARGET) AS defaults,
ROUND(100*AVG(TARGET),2) AS default_rate_pct
FROM application_train
GROUP BY EMI_bands
ORDER BY EMI_bands