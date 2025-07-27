# 🚕 Trip Dashboard – SQL + Power BI Project

A complete analytics project designed to monitor and optimize trip operations using Power BI and SQL Server.



## 🧠 Problem Overview

As part of operational efficiency analysis, the objective was to analyze ride-level data including locations, fares, distances, cancellations, and customer-driver behavior. The aim was to derive insights that help improve trip reliability, payment conversion, and area-specific performance.



## 🛠️ Tools & Technologies

- **Power BI** – For creating interactive dashboards
- **SQL Server** – For data modeling and querying



## ⚙️ Implementation Steps

1. Loaded raw datasets into SQL Server
2. Created views to clean and transform data
3. Wrote SQL queries for metrics like trip count, distance, cancellations, payment mix
4. Imported transformed data into Power BI
5. Built dynamic dashboards with slicers, cards, KPIs, and visuals



## 📊 Dashboard Overview

### 📍 Trip Summary Dashboard

This dashboard offers a complete operational overview including:

- ✅ Total Completed Trips: **983**
- ✅ Total Driver Earnings: **751K**
- ✅ Total Distance Covered: **14,148 KM**
- ✅ Total Searches & Estimates: **2.16K**, **1.8K**
- ✅ Got Quotes: **1K** | Customer Cancellations: **1.1K**
- ✅ Drivers: **30** | Customers: **99**

**Key Insights:**

- Location-wise ride distribution
- Conversion rate by payment method
- Real-time comparison of customers vs drivers
- Trendline for fare, distance, and trip count by duration

<img width="831" height="464" alt="Capture12" src="https://github.com/user-attachments/assets/cce32003-f9f2-4098-a666-b425bbee0d06" />

## 🧾 Sample SQL Queries

```sql
-- Total trips in Trips Table
SELECT COUNT(*) FROM trips;

-- Total trips in trips_details4 Table
SELECT COUNT(*) FROM trips_details4 WHERE end_ride = 1;

-- Area with highest fares/trips
SELECT * FROM (
  SELECT *, RANK() OVER (ORDER BY fare DESC) rnk FROM (
    SELECT loc_from, SUM(fare) AS fare FROM trips
    GROUP BY loc_from
  ) b
) c WHERE rnk = 1;

-- Highest driver-side cancellations
SELECT * FROM (
  SELECT *, RANK() OVER (ORDER BY can DESC) rnk FROM (
    SELECT loc_from, COUNT(*) - SUM(driver_not_cancelled) AS can
    FROM trips_details4
    GROUP BY loc_from
  ) b
) c WHERE rnk = 1;

-- Highest customer-side cancellations
SELECT * FROM (
  SELECT *, RANK() OVER (ORDER BY can DESC) rnk FROM (
    SELECT loc_from, COUNT(*) - SUM(customer_not_cancelled) AS can
    FROM trips_details4
    GROUP BY loc_from
  ) b
) c WHERE rnk = 1;
```
## 📊 Techniques & Features

- ✅ **Joins (INNER, LEFT, SELF)**
- ✅ **Window Functions (RANK, MAX OVER)**
- ✅ **Indexing for Performance**
- ✅ **Nested Queries & CTEs**
- ✅ **Real-World Business Problem Solving**



## 🗂️ Dataset Description

| Table            | Description                                     |
| ---------------- | ----------------------------------------------- |
| `trips`          | Trip journey, pickup/drop location, fare, etc.  |
| `trips_details3` | Search data, quotes, cancellation reasons       |
| `trips_details4` | Completion status, driver/customer cancel flags |
| `loc`            | Location mapping and names                      |
| `duration`       | Time intervals for trips                        |
| `payment`        | Mode of payment used (cash, card, UPI, etc.)    |



## 📁 Folder Structure

```
├── README.md
├── scripts/
│   ├── trip_queries.sql
│   └── trip_dashboard.pbix
├── images/
│   └── trip_dashboard.png
```



## 🔗 Connect With Me  
Feel free to explore more of my projects and reach out:  
- [LinkedIn](https://www.linkedin.com/in/narendrasingh1402)
- [YouTube](https://www.youtube.com/@Analyst_Hive)  
- [Portfolio](https://narendra1402.github.io/)


> 🚀 Let’s make every trip count — through better data!

