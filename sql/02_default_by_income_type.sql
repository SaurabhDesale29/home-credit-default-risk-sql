USE home_credit;
SELECT NAME_INCOME_TYPE,
       COUNT(*)                    AS applications,
       SUM(TARGET)                 AS defaults,
       ROUND(100 * AVG(TARGET), 2) AS default_rate_pct
FROM application_train
GROUP BY NAME_INCOME_TYPE
ORDER BY default_rate_pct DESC;
