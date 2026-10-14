-- q) do the longest delays (over 365 days) look riskier or safer than the 91-180 group?
USE home_credit;
SELECT MIN(worst_delay), MAX(worst_delay), AVG(worst_delay)
FROM customer_delay
WHERE worst_delay > 90;