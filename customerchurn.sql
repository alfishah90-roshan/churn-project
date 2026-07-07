SELECT * FROM hii.customerchurn;


-- How many customers churned?What percentage churned?

SELECT 
round(
100.0 * sum(case when churn = "yes" then 1 else 0 end) / count(*),
2
) as churn_percent
 FROM hii.customerchurn;
 
 
-- Did customers with higher monthly charges leave more often?
SELECT 
  churn,
  ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
  COUNT(*) AS customer_count
FROM hii.customerchurn
GROUP BY churn
ORDER BY churn;


-- Did short-tenure customers leave more often?
SELECT
  CASE
    WHEN tenure < 12 THEN 'Short tenure'
    ELSE 'Long tenure'
  END AS tenure_group,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(
    100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS churn_rate
FROM hii.customerchurn
GROUP BY
  CASE
    WHEN tenure < 12 THEN 'Short tenure'
    ELSE 'Long tenure'
  END;
  
  
  
  -- TO DO SEGEMNT 1. customer

SELECT
  contract,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM hii.customerchurn
GROUP BY contract
ORDER BY churn_rate DESC;


-- tenure segement
SELECT
  CASE
    WHEN tenure < 6 THEN '0-5 months'
    WHEN tenure < 12 THEN '6-11 months'
    WHEN tenure < 24 THEN '12-23 months'
    ELSE '24+ months'
  END AS tenure_bucket,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
  ROUND(100.0 * SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM hii.customerchurn
GROUP BY tenure_bucket
ORDER BY churn_rate DESC;



-- Did short-tenure customers leave more often?
SELECT
  customerid,
  tenure,
  monthlycharges,
  contract,
  CASE
    WHEN tenure < 12
     AND monthlycharges >= 70
     AND contract = 'Month-to-month'
      THEN 'High'

    WHEN tenure < 24
     AND monthlycharges >= 50
      THEN 'Medium'

    ELSE 'Low'
  END AS churn_risk
FROM hii.customerchurn
WHERE churn = 'No';
 