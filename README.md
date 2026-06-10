# 🚚 Last Mile Delivery — Operations & Quality Analysis

## 📌 Project Overview
This project analyzes the **Olist Brazilian E-Commerce dataset** 
(~100,000 orders) to simulate Last Mile Delivery operations — 
including SLA monitoring, seller audits, delivery exception 
detection, and customer quality analysis using SQL Server.

---

## 🎯 Business Problem
E-commerce companies face major challenges in last mile delivery:
- Orders getting delayed beyond SLA
- Sellers missing shipping deadlines
- Poor customer reviews linked to late deliveries
- High freight costs impacting delivery performance

---

## 📂 Project Structure
## 📂 Project Structure
├── schema/create_tables.sql    # Database schema
├── queries/
│   ├── 1_sla_breach.sql        # SLA Breach Detection
│   ├── 2_late_orders.sql       # Late & Failed Orders
│   ├── 3_seller_audit.sql      # Seller Performance Audit
│   ├── 4_review_quality.sql    # Review & Quality Analysis
│   ├── 5_statewise_performance.sql  # State-wise Analysis
│   └── 6_freight_analysis.sql  # Freight vs Order Value
└── data/note.txt               # Dataset source info

---

## 🔍 Key Analysis & Findings

### 1️⃣ SLA Breach Detection
- Identified orders delivered after estimated delivery date
- Calculated exact delay in days per order

### 2️⃣ Late & Failed Orders (Exception Flagging)
- Flagged canceled, unavailable and late delivery orders
- Categorized exceptions by type for audit

### 3️⃣ Seller Performance Audit
- Ranked sellers by shipping breach rate
- Identified high-risk sellers by city and state

### 4️⃣ Customer Review & Quality Analysis
- Correlated low review scores with late deliveries
- Found that 1-2 star reviews had significantly higher delivery days

### 5️⃣ State-wise Delivery Performance
- Mapped SLA breach percentage across all Brazilian states
- Identified top 5 problematic states for operations team

### 6️⃣ Freight vs Order Value Analysis
- Categorized orders by freight-to-price ratio
- Found high freight orders had longer delivery times

---

## 🛠️ Tools Used
- **SQL Server Management Studio (SSMS)**
- **Microsoft SQL Server**
- **Dataset:** [Olist Brazilian E-Commerce — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

---

## 💡 Skills Demonstrated
- Complex JOINs across multiple tables
- CASE WHEN for exception classification
- Window Functions (SUM OVER)
- DATEDIFF for SLA calculations
- Aggregations and GROUP BY analysis
- Subqueries for percentage calculations