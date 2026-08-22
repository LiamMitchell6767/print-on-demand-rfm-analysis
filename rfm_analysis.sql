-- Step 1: Append all monthly sales tables together

CREATE OR REPLACE TABLE `rfm491109.sales.sales2025` AS    
SELECT * FROM `rfm491109.sales.sales202501`
UNION ALL SELECT * FROM `rfm491109.sales.sales202502`
UNION ALL SELECT * FROM `rfm491109.sales.sales202503`
UNION ALL SELECT * FROM `rfm491109.sales.sales202504`
UNION ALL SELECT * FROM `rfm491109.sales.sales202505`
UNION ALL SELECT * FROM `rfm491109.sales.sales202506`
UNION ALL SELECT * FROM `rfm491109.sales.sales202507`
UNION ALL SELECT * FROM `rfm491109.sales.sales202508`
UNION ALL SELECT * FROM `rfm491109.sales.sales202509`
UNION ALL SELECT * FROM `rfm491109.sales.sales202510`
UNION ALL SELECT * FROM `rfm491109.sales.sales202511`
UNION ALL SELECT OrderID, CustomerID, OrderDate, ProductType, OrderValue FROM `rfm491109.sales.sales202512`;  
-- December file contains three unexpected empty columns.
-- Select only the common schema to maintain compatibility.

-- Step 2: Calculate Recency, Frequency, Monetary and R, F, M ranks
-- Combine views with CTEs
CREATE OR REPLACE VIEW `rfm491109.sales.rfm_metrics` AS
WITH current_date AS (
  SELECT DATE('2026-01-01') AS analysis_date -- Analysis snapshot date (chosen after the final transaction in the dataset)
),
rfm AS (
  SELECT
    CustomerID,
    MAX(OrderDate) AS last_order_date,
    DATE_DIFF((SELECT analysis_date FROM current_date), MAX(OrderDate), DAY) AS recency,
    COUNT(*) AS frequency,
    SUM(OrderValue) AS monetary
  FROM `rfm491109.sales.sales2025`
  GROUP BY CustomerID
)
SELECT
  *
FROM rfm;

-- Step 3: Assign RFM scores using deciles (10 = best, 1 = worst)
CREATE OR REPLACE VIEW `rfm491109.sales.rfm_scores` AS
SELECT 
  *,
  NTILE(10) OVER (ORDER BY recency DESC) AS r_score,
  NTILE(10) OVER (ORDER BY frequency ASC) AS f_score,
  NTILE(10) OVER (ORDER BY monetary ASC) AS m_score
FROM `rfm491109.sales.rfm_metrics`;

-- Step 4: Total Score
CREATE OR REPLACE VIEW `rfm491109.sales.rfm_total_scores` AS
SELECT
  CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  (r_score + f_score + m_score) AS rfm_total_score
FROM `rfm491109.sales.rfm_scores`
ORDER BY rfm_total_score DESC;

-- Step 5: BI ready rfm segmants table
CREATE OR REPLACE TABLE `rfm491109.sales.rfm_segments_final` AS
SELECT 
 CustomerID,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  rfm_total_score,
  CASE 
    WHEN rfm_total_score >= 28 THEN 'Champions'
    WHEN rfm_total_score >= 24 THEN 'Loyal VIPs'
    WHEN rfm_total_score >= 20 THEN 'Potential Loyalists'
    WHEN rfm_total_score >= 16 THEN 'Promising'
    WHEN rfm_total_score >= 12 THEN 'Engaged'
    WHEN rfm_total_score >= 8 THEN 'Requires Attention'
    WHEN rfm_total_score >= 4 THEN 'At Risk'
    ELSE 'Lost/Inactive'
  END AS rfm_segment
  FROM `rfm491109.sales.rfm_total_scores`
  ORDER BY rfm_total_score DESC;