🚀 E-Commerce Strategic Marketing: RFM Customer Segmentation
Transforming 500,000+ rows of raw transaction data into actionable business growth insights.

📌 Project Overview
Proyek ini menggunakan dataset Online Retail dari Kaggle untuk mensimulasikan peran seorang Marketing Analyst. Fokus utamanya adalah mengklasifikasikan pelanggan menggunakan metode RFM (Recency, Frequency, Monetary) untuk menentukan strategi pemasaran yang paling efektif bagi setiap segmen.

Tech Stack:

Database: SQL Server (Data Cleaning, Feature Engineering, & Statistical Scoring)

Visualization: Power BI (Interactive Scatter Plot, Treemaps, & Slicers)

💬 The "Manager-Analyst" Conversation (Case Study)
Bagian ini mendokumentasikan proses pengambilan keputusan dan debugging data.

Manager: "Kenapa total revenue kita terlihat sangat besar, tapi ada data yang aneh (negatif)?"

Analyst: "Setelah melakukan audit data pada dataset Kaggle ini, saya menemukan transaksi pembatalan yang ditandai dengan kode 'C' pada InvoiceNo. Saya telah melakukan Data Cleaning untuk memfilter hanya transaksi sukses (Quantity > 0) agar skor loyalitas pelanggan tidak terdistorsi oleh data retur."

Manager: "Siapa pelanggan yang paling harus kita beri perhatian segera?"

Analyst: "Segmen 'At Risk' adalah yang paling kritis. Mereka memiliki frekuensi belanja tinggi di masa lalu tetapi sudah lama tidak bertransaksi. Kita perlu kampanye intervensi sebelum mereka berpindah ke kompetitor."

🛠️ SQL Implementation Details
1. Data Cleaning & Transformation
Menghapus CustomerID yang hilang dan mengeksklusi transaksi negatif/pembatalan agar metrik yang dihasilkan akurat.

SELECT CustomerID, InvoiceDate, InvoiceNo, (Quantity * UnitPrice) AS SalesValue INTO #CleanSales FROM [dbo].[Ecommerce_Kaggle] WHERE CustomerID IS NOT NULL AND Quantity > 0 AND UnitPrice > 0;

2. Calculating RFM Metrics & Scoring
Menggunakan fungsi NTILE(5) untuk membagi pelanggan secara otomatis ke dalam 5 tingkatan peringkat berdasarkan performa mereka (Quintiles).

WITH RFM_Base AS ( SELECT CustomerID, DATEDIFF(DAY, MAX(InvoiceDate), '2011-12-10') AS Recency, COUNT(DISTINCT InvoiceNo) AS Frequency, SUM(SalesValue) AS Monetary FROM #CleanSales GROUP BY CustomerID ) SELECT *, NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score, NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score, NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score FROM RFM_Base;

📊 Dashboard Preview
Key Insights:
Champions Segment: Kelompok kecil namun penyumbang revenue terbesar. Membutuhkan program loyalitas eksklusif untuk menjaga retensi.

Potential Loyalists: Pelanggan dengan Recency baik namun Frequency menengah; merupakan target utama untuk strategi upselling.

Individual Distribution: Scatter plot menampilkan ribuan titik pelanggan secara detail tanpa agregasi berlebih, memungkinkan identifikasi outlier secara cepat.

💡 Strategic Recommendations
Champions (Score 5-5): Berikan akses VIP, reward eksklusif, atau hadiah ulang tahun untuk mempertahankan loyalitas.

Potential Loyalist: Gunakan rekomendasi produk berdasarkan histori belanja untuk meningkatkan frekuensi transaksi.

At Risk: Kirimkan kupon diskon "We Miss You" untuk memicu transaksi kembali dalam waktu dekat sebelum mereka benar-benar churn.
