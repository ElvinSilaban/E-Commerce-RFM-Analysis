# 🚀 E-Commerce Strategic Marketing: RFM Customer Segmentation
*Transforming 500,000+ rows of raw transaction data into actionable business growth insights.*

## 📌 Project Overview
Proyek ini menggunakan dataset **Online Retail** dari Kaggle untuk mensimulasikan peran seorang **Marketing Analyst**. Fokus utamanya adalah mengklasifikasikan pelanggan menggunakan metode **RFM (Recency, Frequency, Monetary)** untuk menentukan strategi pemasaran yang paling efektif bagi setiap segmen.

**Tech Stack:**
- **Database:** SQL Server (Data Cleaning, Feature Engineering, & Statistical Scoring)
- **Visualization:** Power BI (Interactive Scatter Plot, Treemaps, & Slicers)

---

## 💬 The "Manager-Analyst" Conversation (Case Study)
*Bagian ini mendokumentasikan proses pengambilan keputusan dan debugging data.*

> **Manager:** "Kenapa total revenue kita terlihat sangat besar, tapi ada data yang aneh (negatif)?"
> 
> **Analyst:** "Setelah melakukan audit data pada dataset Kaggle ini, saya menemukan transaksi pembatalan yang ditandai dengan kode 'C' pada InvoiceNo. Saya telah melakukan *Data Cleaning* untuk memfilter hanya transaksi sukses (`Quantity > 0`) agar skor loyalitas pelanggan tidak terdistorsi oleh data retur."

> **Manager:** "Siapa pelanggan yang paling harus kita beri perhatian segera?"
> 
> **Analyst:** "Segmen **'At Risk'** adalah yang paling kritis. Mereka memiliki frekuensi belanja tinggi di masa lalu tetapi sudah lama tidak bertransaksi. Kita perlu kampanye intervensi sebelum mereka berpindah ke kompetitor."

---

## 🛠️ SQL Implementation Details

### 1. Data Cleaning & Transformation
Menghapus CustomerID yang hilang dan mengeksklusi transaksi negatif/pembatalan.
```sql
SELECT 
    CustomerID, 
    InvoiceDate, 
    InvoiceNo,
    (Quantity * UnitPrice) AS SalesValue
INTO #CleanSales
FROM [dbo].[Ecommerce_Kaggle]
WHERE CustomerID IS NOT NULL 
  AND Quantity > 0 
  AND UnitPrice > 0;
