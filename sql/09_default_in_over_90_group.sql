-- Q: Inside the "over 90 days" group, does default rate change with how long the delay was?
USE home_credit;      
SELECT CASE
           WHEN d.worst_delay <= 180 THEN '1. 91-180 days'
           WHEN d.worst_delay <= 365 THEN '2. 181-365 days'
           ELSE '3. Over 365 days'
       END AS delay_band,
       COUNT(*)                    AS applications,
       SUM(a.TARGET)               AS defaults,
       ROUND(100 * AVG(a.TARGET), 2) AS default_rate_pct
FROM application_train a
JOIN customer_delay d ON a.SK_ID_CURR = d.SK_ID_CURR
WHERE d.worst_delay > 90
GROUP BY delay_band
ORDER BY delay_band;
