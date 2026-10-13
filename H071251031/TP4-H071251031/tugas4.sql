-- soal 1

SELECT customerNumber, SUM(amount) AS total_pembayaran, 
COUNT(DISTINCT checkNumber) AS jumlah_transaksi, 
MAX(amount) AS pembayaran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4 AND AVG(amount) > 20000;


-- soal 2

SELECT customerNumber, SUM(amount) AS total_pembayaran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_pembayaran DESC;


-- soal 3

SELECT productLine AS kategori_produk, COUNT(productCode) AS jumlah_ragam_produk, 
ROUND(AVG(msrp), 2) AS rata_rata_harga_jual_retail, 
STRING_AGG(productName, ', ' ORDER BY productName) AS daftar_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;


-- soal 4

SELECT DISTINCT reportsTo AS nomor_identifikasi_unik FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber
FROM employees
WHERE jobTitle ILIKE '%VP%' OR jobTitle ILIKE '%President%';


-- soal 5

SELECT productCode AS kode_identifikasi_barang, SUM(quantityOrdered) AS total_unit_terjual, 
ROUND(AVG(priceEach), 2) AS rata_rata_harga_penjualan
FROM orderDetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;


-- soal 6

SELECT productCode AS kode_identifikasi_barang, SUM(quantityOrdered) AS total_unit_dipesan, 
SUM(quantityOrdered * priceEach) AS pendapatan_kotor,
ROUND(AVG(priceEach), 2) AS rata_rata_harga,
MAX(priceEach) - MIN(priceEach) AS rentang_harga
FROM orderDetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY pendapatan_kotor DESC;


-- soal 7

(SELECT customerNumber AS nomor_identifikasi_unik
FROM customers
WHERE creditLimit > 80000
INTERSECT
SELECT customerNumber
FROM orders
WHERE status IN ('Cancelled', 'On Hold'))
EXCEPT
(
SELECT customerNumber
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 100000
);

-- studyCase 1
SELECT COUNT(productLine) AS jumlah_kategori_produk, ROUND(AVG(msrp - buyPrice), 2) AS rata_rata_margin
FROM products
WHERE quantityInStock > 1000
GROUP BY productLine
HAVING COUNT(productCode) >= 5
ORDER BY rata_rata_margin;
