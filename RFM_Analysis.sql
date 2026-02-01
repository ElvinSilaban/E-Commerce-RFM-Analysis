/* ==========================================================================
PROJECT: E-Commerce Customer Segmentation using RFM Analysis
PURPOSE: Cleaning data, calculating RFM scores, and creating segments.
==========================================================================
*/

-- STEP 1: Cleaning Data (Menghapus NULL dan transaksi negatif/pembatalan)
SELECT * INTO #CleanData
FROM [dbo].[YourTableName] -- Ganti dengan nama tabelmu
WHERE CustomerID IS NOT NULL 
  AND Quantity > 0 
  AND UnitPrice > 0;

-- STEP 2: Menghitung Nilai Recency, Frequency, & Monetary per Pelanggan
-- Kita asumsikan tanggal referensi adalah 2011-12-10 (akhir data)
WITH RFM_Base AS (
    SELECT 
        CustomerID,
        DATEDIFF(DAY, MAX(InvoiceDate), '2011-12-10') AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(Quantity * UnitPrice) AS Monetary
    FROM #CleanData
    GROUP BY CustomerID
)

-- STEP 3: Memberikan Skor (1-5) menggunakan NTILE
, RFM_Scores AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM_Base
)

-- STEP 4: Membuat View untuk Power BI (Final Segmentation)
-- Jalankan bagian ini di SSMS kamu agar tersimpan sebagai View
CREATE VIEW View_Marketing_RFM_Final AS
SELECT *,
    CASE 
        WHEN R_Score = 5 AND F_Score = 5 THEN '1. Champions'
        WHEN R_Score >= 4 AND F_Score >= 4 THEN '2. Loyal Customers'
        WHEN R_Score >= 4 AND F_Score = 1 THEN '3. New Customers'
        WHEN R_Score = 1 THEN '4. At Risk / Lost'
        ELSE '5. Potential Loyalist' 
    END AS Customer_Segment
FROM RFM_Scores;