USE SupplyChainAnalytics;
GO

-- 1. Supplier Performance
SELECT
    Supplier,
    COUNT(*) AS Total_Orders,
    SUM(Order_Value) AS Total_Order_Value,
    AVG(Delivery_Variance) AS Avg_Delivery_Variance
FROM SupplyChainInventory
GROUP BY Supplier
ORDER BY Total_Order_Value DESC;


-- 2. Order Status Distribution
SELECT
    Order_Status,
    COUNT(*) AS Order_Count,
    CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS DECIMAL(5,2)) AS Percentage
FROM SupplyChainInventory
GROUP BY Order_Status
ORDER BY Order_Count DESC;


-- 3. Warehouse-wise Inventory Analysis
SELECT
    Warehouse,
    SUM(Stock_Level) AS Total_Stock,
    SUM(Reorder_Level) AS Total_Reorder_Level,
    SUM(Pending_Quantity) AS Total_Pending_Quantity
FROM SupplyChainInventory
GROUP BY Warehouse
ORDER BY Total_Stock DESC;


-- 4. Product-wise Pending Quantity
SELECT
    Product,
    SUM(Pending_Quantity) AS Total_Pending_Quantity
FROM SupplyChainInventory
GROUP BY Product
ORDER BY Total_Pending_Quantity DESC;


-- 5. Monthly Order Value Trend
SELECT
    YEAR(Order_Date) AS Order_Year,
    MONTH(Order_Date) AS Order_Month,
    SUM(Order_Value) AS Monthly_Order_Value
FROM SupplyChainInventory
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Order_Year, Order_Month;


-- 6. Delivery Performance
SELECT
    Supplier,
    COUNT(*) AS Total_Orders,
    AVG(Expected_Delivery_Days) AS Avg_Expected_Days,
    AVG(Actual_Delivery_Days) AS Avg_Actual_Days,
    AVG(Delivery_Variance) AS Avg_Delivery_Variance
FROM SupplyChainInventory
GROUP BY Supplier
ORDER BY Avg_Delivery_Variance DESC;


-- 7. Low Stock / Reorder Analysis
SELECT
    Warehouse,
    Product,
    Stock_Level,
    Reorder_Level,
    Inventory_Status
FROM SupplyChainInventory
WHERE Inventory_Status IN ('Low Stock', 'Reorder')
ORDER BY Stock_Level ASC;


-- 8. Top Products by Order Value
SELECT
    Product,
    Category,
    SUM(Order_Value) AS Total_Order_Value,
    SUM(Quantity_Ordered) AS Total_Quantity_Ordered
FROM SupplyChainInventory
GROUP BY Product, Category
ORDER BY Total_Order_Value DESC;


-- 9. Final Data Validation
SELECT
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT Order_ID) AS Unique_Orders,
    COUNT(DISTINCT Supplier) AS Suppliers,
    COUNT(DISTINCT Product) AS Products,
    COUNT(DISTINCT Warehouse) AS Warehouses,
    MIN(Order_Date) AS Start_Date,
    MAX(Order_Date) AS End_Date
FROM SupplyChainInventory;