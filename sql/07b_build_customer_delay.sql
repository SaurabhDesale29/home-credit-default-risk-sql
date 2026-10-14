USE home_credit;

DROP TABLE IF EXISTS customer_delay;

CREATE TABLE customer_delay AS
SELECT SK_ID_CURR,
       MAX(DAYS_ENTRY_PAYMENT - DAYS_INSTALMENT)   AS worst_delay,
       COUNT(*)                                    AS instalments,
       SUM(DAYS_ENTRY_PAYMENT > DAYS_INSTALMENT)   AS late_instalments
FROM installments_payments IGNORE INDEX (idx_inst_curr)
GROUP BY SK_ID_CURR;

ALTER TABLE customer_delay ADD PRIMARY KEY (SK_ID_CURR);

SELECT * FROM customer_delay LIMIT 20;