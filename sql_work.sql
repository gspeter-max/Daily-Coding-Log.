WITH CustomerSummary AS (
    SELECT 
        customer_id,
        DATEDIFF(CURRENT_DATE, MAX(transaction_date)) AS recency,
        COUNT(transaction_id) AS frequency,
        SUM(amount) AS monetary_value
    FROM Transactions
    GROUP BY customer_id
)
SELECT 
    customer_id,
    recency,
    frequency,
    monetary_value,
    CASE 
        WHEN recency <= 30 THEN 1
        WHEN recency <= 90 THEN 2
        ELSE 3
    END AS recency_score,
    CASE 
        WHEN frequency >= 10 THEN 1
        WHEN frequency >= 5 THEN 2
        ELSE 3
    END AS frequency_score,
    CASE 
        WHEN monetary_value >= 1000 THEN 1
        WHEN monetary_value >= 500 THEN 2
        ELSE 3
    END AS monetary_score
FROM CustomerSummary;
