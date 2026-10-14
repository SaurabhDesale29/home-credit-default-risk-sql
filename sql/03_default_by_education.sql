USE home_credit;
SELECT NAME_EDUCATION_TYPE,
	   count(*) AS applications,
       sum(TARGET) AS defaults,
       ROUND(100*AVG(TARGET),2) AS default_rate_pct
FROM application_train
GROUP BY NAME_EDUCATION_TYPE
HAVING COUNT(*) >= 1000
ORDER BY default_rate_pct DESC;