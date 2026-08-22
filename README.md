# Print-on-Demand Sales & Customer RFM Analysis

## Project Overview
This project analyzes sales and customer data from a print-on-demand business. 

I used [SQL](https://github.com/LiamMitchell6767/print-on-demand-rfm-analysis/blob/e57d04f39a23a504a62bfda5466fcd95a72ba8f8/rfm_analysis.sql) in Google BigQuery to combine the 12 monthly sales tables from 2025, calculate customer-level RFM metrics, and assign customers to RFM segments. I then connected the resulting dataset to Power BI to analyze sales trends, product performance, and customer purchasing behavior.

The main focus was on understanding **sales trends, product performance, and customer purchasing behavior**.

## Dashboard

![Sales Segmentation - RFM Analysis](https://github.com/LiamMitchell6767/print-on-demand-rfm-analysis/blob/dcd344cbdabff0f278ef3ba0ca64e0b548a64363/RFM%20Dashboard.png)
[View Power BI Dashboard](https://github.com/LiamMitchell6767/print-on-demand-rfm-analysis/blob/e57d04f39a23a504a62bfda5466fcd95a72ba8f8/RFM%20Dashboard.pbix)

## Tools

**Google BigQuery, SQL, Power BI**

## What I did

- Cleaned and Combined the 12 monthly sales tables from 2025 using SQL
- Calculated Recency, Frequency, and Monetary values for each customer
- Used `NTILE(10)` to assign customers to 10 score groups for each RFM measure
- Added the three scores together to create an overall RFM score
- Grouped customers into different segments based on their RFM scores
- Built a Power BI dashboard to compare sales, products, and customer segments

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
| Lost/Inactive | <4 |

## Some findings

- Total sales for 2025 were **$17.07K** across **287 customers**.
- **Canvas Prints** were the top-selling product type, generating **$6.2K (36%)** of total sales. **Photo Books** followed with **$3.8K (22%)**.
- **Loyal VIPs** generated the most sales among the customer segments at **$4.4K**, followed by **Potential Loyalists** at **$3.1K**. Together, these two segments generated about **44% of total sales**.
- There are **68 customers** in the **Requires Attention** and **At Risk** segments, which could be a useful group to target with re-engagement campaigns.

## Data Workflow

```text
Monthly Sales Tables
        ↓
Combine 2025 Sales
        ↓
Calculate RFM Metrics
        ↓
Calculate RFM Scores
        ↓
Create Customer Segments
        ↓
Power BI Dashboard
```

Note: The dataset and business used in this project are fictional and created for portfolio purposes.
