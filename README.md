# 🛒 Blinkit Sales Analysis — End to End Data Analytics Project

![Blinkit](https://img.shields.io/badge/Domain-Quick%20Commerce-yellow)
![Tools](https://img.shields.io/badge/Tools-Excel%20%7C%20PostgreSQL%20%7C%20Power%20BI-blue)
![Status](https://img.shields.io/badge/Status-Completed-green)

---

## 📌 Project Overview

This is an end-to-end data analytics project analyzing Blinkit's sales performance across 8 Indian cities and 8 product categories. The goal was to identify revenue drivers, delivery performance, return patterns, and customer payment behaviour using real-world data analytics tools.

> *"Analyzed 500+ rows of Blinkit sales data using Excel for data cleaning, PostgreSQL for business analysis, and Power BI for interactive dashboard reporting."*

---

## 🎯 Business Problem

A quick-commerce company wants to understand:
- Which product categories are driving the most revenue?
- Which cities are performing best in terms of sales and delivery?
- What percentage of orders are being returned or cancelled?
- Which payment methods are most preferred by customers?
- How are sales trending month over month?

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| Microsoft Excel | Data cleaning and preprocessing |
| PostgreSQL (pgAdmin) | Business analysis using SQL |
| Power BI | Interactive dashboard and visualization |
| GitHub | Project documentation and version control |

---

## 📂 Project Structure

```
Blinkit-Sales-Analysis/
│
├── Data/
│   ├── Blinkit_Raw_Data.xlsx          # Original messy dataset
│   └── Blinkit_Cleaned_Data.csv       # Cleaned dataset ready for SQL
│
├── SQL/
│   └── Blinkit_Analysis_Queries.sql   # All 12 SQL queries
│
├── Dashboard/
│   └── Blinkit_Dashboard.png          # Power BI dashboard screenshot
│
└── README.md
```

---

## 🧹 Step 1 — Data Cleaning (Excel)

The raw dataset had the following issues which were fixed in Excel:

| Issue | Fix Applied |
|-------|------------|
| 15 duplicate rows | Removed using Data → Remove Duplicates |
| Inconsistent category names (grocery, BEVERAGES) | Standardized using Find & Replace |
| Inconsistent city names (delhi, MUMBAI, Bengaluru) | Standardized using Find & Replace |
| Mixed date formats (YYYY-MM-DD and DD/MM/YYYY) | Converted to uniform DD-MM-YYYY format |
| Negative quantity values | Corrected to absolute values |
| Zero sales where quantity > 0 | Recalculated using formula: =Quantity×Unit_Price×(1-Discount%/100) |
| Blank values in City, Rating, Delivery Time | Filled with Unknown / median values |

**Result:** Clean dataset with 503 rows ready for analysis.

---

## 🗄️ Step 2 — SQL Analysis (PostgreSQL)

Wrote 12 business-focused SQL queries covering all major concepts:

### Query Concepts Covered:

| # | Business Question | SQL Concept |
|---|------------------|-------------|
| 1 | Overall business performance | Aggregation — COUNT, SUM, AVG |
| 2 | Sales & profit by category | GROUP BY + ORDER BY |
| 3 | Top 10 customers by sales | ORDER BY + LIMIT |
| 4 | High performing categories | HAVING |
| 5 | City wise sales & delivery performance | Multiple Aggregations |
| 6 | Order status breakdown with % | CASE WHEN |
| 7 | Monthly sales trend | DATE Functions |
| 8 | Cumulative running total of sales | Window Function — SUM OVER |
| 9 | Product ranking within each category | Window Function — RANK() OVER PARTITION BY |
| 10 | Top 3 products per category | Subquery + Window Function |
| 11 | Return rate by category | CASE WHEN + Subquery |
| 12 | Payment method preference | GROUP BY + Window Function |

### Sample Query — Top 3 Products Per Category:
```sql
SELECT * FROM (
    SELECT 
        category,
        product_name,
        ROUND(SUM(sales),2) AS total_sales,
        RANK() OVER(PARTITION BY category ORDER BY SUM(sales) DESC) AS sales_rank
    FROM blinkit_sales
    GROUP BY category, product_name
) AS ranked_products
WHERE sales_rank <= 3
ORDER BY category, sales_rank;
```

---

## 📊 Step 3 — Power BI Dashboard

Built an interactive dashboard with Blinkit branding covering:

- **KPI Cards** — Total Orders, Total Sales, Total Profit, Avg Delivery Time
- **Sales by Category** — Horizontal bar chart showing category wise revenue
- **Monthly Sales & Profit Trend** — Line and clustered column chart
- **Order Status Breakdown** — Donut chart with delivery/cancellation/return %
- **Payment Method Preference** — Pie chart showing UPI vs COD vs Card usage
- **Sales by City** — Column chart comparing 8 cities
- **City Slicer** — Interactive filter to drill down by city

---

## 📈 Key Business Insights

1. **Meat & Fish and Baby Care** are the top revenue generating categories, contributing the highest sales among all 8 categories
2. **63.22% orders are successfully delivered** while 20.68% are cancelled — indicating room for operational improvement
3. **October recorded the highest sales spike** suggesting seasonal demand or promotional activity
4. **Cash on Delivery (21.67%) and UPI (20.48%)** are the most preferred payment methods showing customers still prefer traditional payment options
5. **Mumbai leads in city wise sales** followed closely by Bangalore and Delhi
6. **Average delivery time is 25.74 minutes** across all cities which is competitive for quick commerce

---

## 🚀 How to Run This Project

1. Download `Blinkit_Cleaned_Data.csv` from the Data folder
2. Open pgAdmin and create a database called `blinkit_db`
3. Run the CREATE TABLE query from `Blinkit_Analysis_Queries.sql`
4. Import the CSV file into the `blinkit_sales` table
5. Run the 12 SQL queries one by one
6. Open Power BI and connect to the CSV to explore the dashboard

---

## 👩‍💻 Author

**Prerna Malhotra**  
Aspiring Data Analyst | SQL • Excel • Power BI  
📧 prernamalhotra767@gmail.com 
🔗 https://www.linkedin.com/in/prerna-malhotra-/

---

⭐ If you found this project helpful, please give it a star!
