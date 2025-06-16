# Mint Classics SQL Analysis Project

## 📊 Project Overview

This project analyzes business data from the **Mint Classics** MySQL database using SQL. The database contains information on customers, employees, orders, products, payments, and more. The objective was to generate actionable business insights across inventory management, sales performance, supplier evaluation, and customer segmentation.

## 🛠️ Tools Used

- **MySQL 8.0**
- **MySQL Workbench** for writing and testing queries
- **GitHub** for version control and documentation

---

## 🎯 Project Objectives

- Explore and understand the Mint Classics database structure
- Perform inventory, sales, and customer behavior analysis
- Identify top-selling and underperforming products
- Evaluate suppliers based on lead time and contribution to revenue
- Highlight data quality issues and recommend operational improvements

---

## ✅ Key Questions Answered

### 📦 Inventory & Products
- How many products are in stock?
- What is the average, min, and max price?
- Which products have never been sold?
- Which items are overstocked or about to run out?
- Which product categories generate the most revenue?

### 💰 Sales & Transactions
- What are the monthly sales trends?
- What are the top 5 best-selling products?
- Are there seasonal demand patterns?
- Which products had no sales in the last 6 months?

### 📈 Performance Insights
- What is the turnover rate of each product?
- Which suppliers have the longest/shortest lead times?
- Which suppliers contribute the most to revenue?

### 🌍 Customer & Employee Insights
- How many customers are there per country?
- How many customers does each sales rep manage?

### 🧹 Data Quality
- Are there null values in critical product fields?
- Are there duplicate products or inconsistent entries?
- Are there pricing or inventory errors?

---

## 🧠 My Approach

1. **Data Understanding**  
   Loaded and examined all relevant tables to understand relationships and dependencies (e.g., `orders`, `orderdetails`, `products`, `customers`, etc.).

2. **Query Building**  
   Wrote layered SQL queries with `JOIN`, `GROUP BY`, aggregate functions (`SUM`, `AVG`, `COUNT`), and date functions to extract metrics and trends.

3. **Performance Metrics**  
   Focused on business-relevant KPIs like product turnover, revenue per product line, lead time per supplier, and monthly unit sales.

4. **Data Validation**  
   Checked for NULLs, duplicates, and logical errors in inventory and pricing to ensure accurate results.

5. **Business Recommendations**  
   Translated query results into decisions such as:
   - Restocking low-inventory high-selling products
   - Flagging unsold or overstocked items
   - Prioritizing fast, high-revenue suppliers
   - Discontinuing consistently underperforming items

---

## 📌 Key Insights

| Area | Finding | Business Value |
|------|---------|----------------|
| **Inventory** | 5 products had never been sold | Eliminate waste and improve SKU efficiency |
| **Sales** | Top 5 products accounted for 30%+ of unit sales | Focus marketing and stock on best-sellers |
| **Suppliers** | One supplier had a 4x longer lead time than another | Improve delivery speed by reprioritizing vendors |
| **Customers** | US and France had the largest customer base | Tailor promotions by region |
| **Data Quality** | 3 products had MSRP lower than cost price | Prevent margin loss due to pricing issues |

---

## 📂 Files in Repository

- `mintclassics_queries.sql` – Final SQL script with all queries, grouped and commented

---

## 📎 Conclusion

This project demonstrates how SQL can be used to drive meaningful business decisions from raw transactional data. From inventory planning and supplier evaluation to customer targeting and seasonal strategy — SQL can answer key operational questions with clarity and precision.

---

## 🙋‍♂️ About Me

I'm a data enthusiast in SQL, Python, Power BI, and Excel. I love turning raw data into clear, actionable insights that empower better business decisions.


