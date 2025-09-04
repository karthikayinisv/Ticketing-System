-------- july percentage -----
DECLARE @OpeningMonth VARCHAR(20) = 'March';  
DECLARE @ClosingMonth VARCHAR(20) = 'July';  

WITH StockSummary AS (
    SELECT [Outlet id], [Outlet Name],
        SUM(CASE WHEN [Month] = @OpeningMonth AND [Stock Status] = 'Opening' 
                 THEN [Closing stock] ELSE 0 END) AS Total_Opening_Stock,
        SUM(CASE WHEN [Month] = @ClosingMonth AND [Stock Status] = 'Closing' 
                 THEN [Closing stock] ELSE 0 END) AS Total_Closing_Stock
    FROM Stock_Audit_Analysis
    GROUP BY [Outlet id], [Outlet Name]
),
SalesSummary AS (
    SELECT DealerName, [State], Region,
        SUM(CASE WHEN SalesSource = 'Primary' THEN Quantity ELSE 0 END) AS Primary_Qty,
        SUM(CASE WHEN SalesSource = 'Secondary' THEN Quantity ELSE 0 END) AS Secondary_Qty
    FROM (
        SELECT 'Primary' AS SalesSource, VMP.Quantity,
               SFD.[Outlet Name] AS DealerName, SFD.[State], SFD.Region
        FROM [CUSTOMER_MASTER].[dbo].[VM_Primary_Sales-All] AS VMP
        LEFT JOIN Raymedi_Outlet AS RO ON VMP.custcard = RO.Navcode
        LEFT JOIN SF_Dealer_State_Master AS SFD ON RO.OutletID = CAST(SFD.[Outlet ID] AS varchar)
        WHERE VMP.Financialyear = '2025-2026'
          AND VMP.Customercategory = 'Domestic Dealer'
          AND VMP.[Customer subcategory] = 'Dealer'
        
        UNION ALL
        
        SELECT 'Secondary' AS SalesSource, SFB.[Sales Quantity] AS Quantity,
               SFD.[Outlet Name] AS DealerName, SFD.[State], SFD.Region
        FROM SF_Data_Porting_BK11 AS SFB
        LEFT JOIN SF_Dealer_State_Master AS SFD 
               ON CAST(SFD.[Outlet ID] AS varchar) = SFB.Outlet_ID
        WHERE SFB.[Sales Source] = 'Secondary'
    ) AS Combined
    GROUP BY DealerName, [State], Region
)
SELECT 
    s.[Outlet id], 
    s.[Outlet Name],
    ISNULL(s.Total_Opening_Stock, 0) AS Total_Opening_Stock,
    ISNULL(ss.Primary_Qty, 0) AS Primary_Qty,
    ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Total_Opening_Stock, 0) AS PrimaryTotal,
    ISNULL(s.Total_Closing_Stock, 0) AS Total_Closing_Stock,
    ISNULL(ss.Secondary_Qty, 0) AS Secondary_Qty,
    ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Total_Closing_Stock, 0) AS Secondary_Total,
    ss.[State], 
    ss.Region,
    CONCAT(
        CAST(
            ROUND(
                CAST((ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Total_Closing_Stock, 0)) AS FLOAT)
                / NULLIF((ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Total_Opening_Stock, 0)), 0) * 100, 
            0) 
        AS VARCHAR(10)), ' %'
    ) AS JulyMonthpercentage
FROM StockSummary s
LEFT JOIN SalesSummary ss ON s.[Outlet Name] = ss.DealerName
ORDER BY s.[Outlet Name];



---------------- April to Aug month percentage  -------------
--WITH StockSummary AS (
--    SELECT
--        [Outlet id],
--        [Outlet Name],
--        SUM(CASE WHEN [Month] = @OpeningMonth AND [Stock Status] = 'Opening' 
--                 THEN [Closing stock] ELSE 0 END) AS Opening_March,
--        SUM(CASE WHEN [Month] = 'April'  AND [Stock Status] = 'Closing' THEN [Closing stock] ELSE 0 END) AS Closing_April,
--        SUM(CASE WHEN [Month] = 'May'    AND [Stock Status] = 'Closing' THEN [Closing stock] ELSE 0 END) AS Closing_May,
--        SUM(CASE WHEN [Month] = 'June'   AND [Stock Status] = 'Closing' THEN [Closing stock] ELSE 0 END) AS Closing_June,
--        SUM(CASE WHEN [Month] = 'July'   AND [Stock Status] = 'Closing' THEN [Closing stock] ELSE 0 END) AS Closing_July,
--        SUM(CASE WHEN [Month] = 'August' AND [Stock Status] = 'Closing' THEN [Closing stock] ELSE 0 END) AS Closing_August
--    FROM Stock_Audit_Analysis
--    GROUP BY [Outlet id], [Outlet Name]
--),

---- Step 2: Get sales summary per dealer (with State & Region included)
--SalesSummary AS (
--    SELECT	
--        DealerName,
--        [State],
--        Region,
--        SUM(CASE WHEN SalesSource = 'Primary' THEN Quantity ELSE 0 END) AS Primary_Qty,
--        SUM(CASE WHEN SalesSource = 'Secondary' THEN Quantity ELSE 0 END) AS Secondary_Qty
--    FROM (
--        -- Primary Sales
--        SELECT 
--            'Primary' AS SalesSource,
--            VMP.Quantity,
--            SFD.[Outlet Name] AS DealerName,
--            SFD.[State],
--            SFD.Region
--        FROM [CUSTOMER_MASTER].[dbo].[VM_Primary_Sales-All] AS VMP
--        LEFT JOIN Raymedi_Outlet AS RO 
--            ON VMP.custcard = RO.Navcode
--        LEFT JOIN SF_Dealer_State_Master AS SFD 
--            ON RO.OutletID = CAST(SFD.[Outlet ID] AS varchar)
--        WHERE VMP.Financialyear = '2025-2026'
--          AND VMP.Customercategory = 'Domestic Dealer'
--          AND VMP.[Customer subcategory] = 'Dealer'

--        UNION ALL

--        -- Secondary Sales
--        SELECT 
--            'Secondary' AS SalesSource,
--            SFB.[Sales Quantity] AS Quantity,
--            SFD.[Outlet Name] AS DealerName,
--            SFD.[State],
--            SFD.Region
--        FROM SF_Data_Porting_BK11 AS SFB
--        LEFT JOIN SF_Dealer_State_Master AS SFD 
--            ON CAST(SFD.[Outlet ID] AS varchar) = SFB.Outlet_ID
--        WHERE SFB.[Sales Source] = 'Secondary'
--    ) AS Combined
--    GROUP BY DealerName, [State], Region
--)

---- Step 3: Final Output with Monthly Percentages
--SELECT
--    s.[Outlet id],
--    s.[Outlet Name],
--    s.Opening_March,
--    ss.Primary_Qty,
--    ss.Secondary_Qty,
--    ss.[State],
--    ss.Region,

--    -- April %
--    CONCAT(CAST(ROUND(
--        CAST((ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Closing_April, 0)) AS FLOAT)
--        / NULLIF((ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Opening_March, 0)), 0) * 100, 0
--    ) AS VARCHAR(10)), ' %') AS AprilPercentage,

--    -- May %
--    CONCAT(CAST(ROUND(
--        CAST((ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Closing_May, 0)) AS FLOAT)
--        / NULLIF((ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Opening_March, 0)), 0) * 100, 0
--    ) AS VARCHAR(10)), ' %') AS MayPercentage,

--    -- June %
--    CONCAT(CAST(ROUND(
--        CAST((ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Closing_June, 0)) AS FLOAT)
--        / NULLIF((ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Opening_March, 0)), 0) * 100, 0
--    ) AS VARCHAR(10)), ' %') AS JunePercentage,

--    -- July %
--    CONCAT(CAST(ROUND(
--        CAST((ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Closing_July, 0)) AS FLOAT)
--        / NULLIF((ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Opening_March, 0)), 0) * 100, 0
--    ) AS VARCHAR(10)), ' %') AS JulyPercentage,

--    -- August %
--    CONCAT(CAST(ROUND(
--        CAST((ISNULL(ss.Secondary_Qty, 0) + ISNULL(s.Closing_August, 0)) AS FLOAT)
--        / NULLIF((ISNULL(ss.Primary_Qty, 0) + ISNULL(s.Opening_March, 0)), 0) * 100, 0
--    ) AS VARCHAR(10)), ' %') AS AugustPercentage

--FROM StockSummary s
--LEFT JOIN SalesSummary ss
--    ON s.[Outlet Name] = ss.DealerName
--ORDER BY s.[Outlet Name];