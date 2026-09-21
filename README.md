# Print-on-Demand Sales & Customer RFM Analysis

## Project Overview

This project analyzes 2025 sales and customer data from a fictional print-on-demand business, with a focus on customer value, purchasing behavior, and retention.

I used [SQL](https://github.com/LiamMitchell6767/print-on-demand-rfm-analysis/blob/e57d04f39a23a504a62bfda5466fcd95a72ba8f8/rfm_analysis.sql) in Google BigQuery to combine 12 monthly sales tables, calculate customer-level Recency, Frequency, and Monetary (RFM) metrics, and assign customers to different RFM segments.

I then connected the processed data to Power BI to explore sales performance, customer behavior, and possible opportunities for customer growth and retention.

## Business Questions

The analysis focused on three main questions:

- Which customer segments are most valuable to the business?
- Which customers have the strongest potential for repeat purchases?
- Which inactive customers are most worth targeting with retention or reactivation campaigns?

## Dashboard

![Sales Segmentation - RFM Analysis](https://github.com/LiamMitchell6767/print-on-demand-rfm-analysis/blob/dcd344cbdabff0f278ef3ba0ca64e0b548a64363/RFM%20Dashboard.png)

[View Power BI Dashboard](https://github.com/LiamMitchell6767/print-on-demand-rfm-analysis/blob/e57d04f39a23a504a62bfda5466fcd95a72ba8f8/RFM%20Dashboard.pbix)

## Tools

Google BigQuery, SQL, Power BI

## Methodology

### Data Preparation

- Cleaned and combined 12 monthly sales tables from 2025 using SQL
- Combined the data into one annual sales table
- Aggregated transactions to the customer level

### RFM Analysis

For each customer, I calculated:

- **Recency** — days since the customer's most recent purchase
- **Frequency** — number of purchases made during the year
- **Monetary** — total amount spent

I used `NTILE(10)` to divide customers into 10 score groups for each RFM measure.

The three scores were then added together to create an overall RFM score, which was used to assign customers to different segments.

## RFM Segments

| Segment | RFM Score |
|---|---:|
| Champions | 28–30 |
| Loyal VIPs | 24–27 |
| Potential Loyalists | 20–23 |
| Promising | 16–19 |
| Engaged | 12–15 |
| Requires Attention | 8–11 |
| At Risk | 4–7 |
| Lost / Inactive | <4 |

## Key Insights & Recommendations

### 1. Potential Loyalists may be more valuable to target for repeat purchases than larger basket sizes

**Insight**

Potential Loyalists averaged 4.3 purchases and $80.02 in total spend, compared with 5.7 purchases and $102.36 for Loyal VIPs.

However, their average spend per purchase was very similar:

- Potential Loyalists: $18.61
- Loyal VIPs: $17.96

The main difference between the two groups appears to be how often they purchase, rather than how much they spend each time.

**Recommendation**

Focus on getting Potential Loyalists to purchase more often instead of trying to increase their basket size.

This could include loyalty rewards, personalized follow-ups, or repeat-purchase offers, with results tracked through changes in purchase frequency and repeat-purchase rate.

---

### 2. Retention campaigns could be tested before customers become heavily inactive

**Insight**

The Engaged segment was the largest customer group, with 66 customers, making up around 23% of the customer base and 17% of total sales.

These customers had already gone an average of 108 days since their last purchase.

Average recency increased further across the less-active segments:

| Segment | Average Recency |
|---|---:|
| Engaged | 108 days |
| Requires Attention | 149 days |
| At Risk | 196 days |

By the time customers reach the At Risk segment, they have already been inactive for a fairly long period.

**Recommendation**

Test retention campaigns earlier, while customers are still in the Engaged segment.

For example, reminders, personalized recommendations, or targeted offers could be tested around the 90–120 day inactivity range, then compared with a control group to see whether they improve repeat purchases.

The current data does not show the best intervention point, so this range should be treated as a starting point for testing rather than a fixed rule.

---

### 3. Not every inactive customer appears equally valuable to reactivate

**Insight**

Requires Attention and At Risk customers together accounted for 68 customers — nearly one-quarter of the customer base — but only around 10% of total sales.

At Risk customers also averaged only:

- 1.5 purchases
- $18.13 in total spend

This means many customers in the At Risk segment may not actually be previously valuable customers who later stopped purchasing.

Because the current segmentation uses a combined RFM score, customers with low frequency and low spending can end up in the same broad segment as customers who were previously valuable but have recently become inactive.

**Recommendation**

Separate inactive customers into two groups:

- Previously high-value customers who have become inactive
- Customers who have consistently shown low engagement and low spending

Higher-value win-back offers could then be focused on customers with a stronger purchase history, while lower-value inactive customers could receive cheaper automated campaigns.

This would help avoid spending the same amount trying to reactivate customers with very different levels of past value.

