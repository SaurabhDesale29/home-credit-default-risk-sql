-- q) Does paying the emi on time effects the default percentage?

USE home_credit;

SELECT  
       CASE WHEN worst_delay IS NULL THEN "0. No payment history"
			WHEN worst_delay <= 0 THEN "1. Never late"
            WHEN worst_delay <=30 THEN "2. 1-30 days"
            WHEN worst_delay <=60 THEN "3. 31-60 days"
            WHEN worst_delay <=90 THEN "4. 61-90 days"
            ELSE "5. Over 90 days"
		END AS delay_details,
        count(*) AS applications,
       sum(TARGET) AS defaults,
       ROUND(100*AVG(TARGET),2) AS default_rate_pct
	   FROM application_train at
       LEFT JOIN customer_delay cd
       ON at.SK_ID_CURR = cd.SK_ID_CURR
       GROUP BY delay_details
       ORDER BY delay_details ASC;
       
 