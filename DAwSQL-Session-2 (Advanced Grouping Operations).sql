-- 15.07.2021 DawSQL Sessinon 2

-- CROSS JOIN
-- Write a query that returns the table to be used to add products that are in the Products table 
-- but not in the stocks table to the stocks table with quantity = 0. 
-- (Do not forget to add products to all stores.)
-- Expected columns: store_id, product_id, quantity

SELECT B.store_id, A.product_id, A.product_name, 0 quantity -- quantity ad�nda s�tun olu�turup i�ine 0 giriyor
FROM production.products AS A
CROSS JOIN sales.stores AS B
WHERE A.product_id NOT IN (SELECT product_id FROM production.stocks)
ORDER BY A.product_id, B.store_id

----- CROSS JOIN-----

-- Soru1: Hangi markada hangi kategoride ka�ar �r�n oldu�u bilgisine ihtiya� duyuluyor
-- �r�n say�s� hesaplamadan sadece marka * kategori ihtimallerinin hepsini i�eren bir tablo olu�turun
-- ��kan sonucu daha kolay yorumlamak i�in brand_id ve category_id alanlar�na g�re s�ralay�n.

SELECT *
FROM production.brands
CROSS JOIN production.categories
ORDER BY brand_id  -- ORDER BY production.brands.brand_id olarak da uzun yaz�labilir.

----- SELF JOIN------

-- Soru2: Write a query that returns the staff with their managers.
-- Expected columns: staff first name, staff last name, manager name

SELECT *
FROM sales.staffs

SELECT *
FROM sales.staffs AS A
JOIN sales.staffs AS B
ON A.manager_id = B.staff_id

SELECT *
FROM sales.staffs

SELECT A.first_name AS Staff_Name, A.last_name AS Staff_Last, B.first_name AS Manager
FROM sales.staffs A, sales.staffs B
WHERE  A.manager_id = B.staff_id


---- GROUPBY / HAVING ----

--GROUPING OPERATION SORU1-- 
--Write a query that checks if any product id is repeated in more than one row in the products table.
--TR: �r�nler tablosunda herhangi bir �r�n kimli�inin birden fazla sat�rda tekrarlan�p tekrarlanmad���n� kontrol eden bir sorgu yaz�n

SELECT product_name, COUNT(product_name)
FROM production.products
GROUP BY product_name
HAVING COUNT(product_name) >1; --HAVING�DE kulland���n s�tun Aggregate te kulland���n s�tun ismiyle ayn� olmal�. 

-- hocan�n ��z�m�:
-- �nce products lar� g�relim.
SELECT TOP 20* 
FROM production.products

SELECT product_id, COUNT(*) AS CNT_PRODUCT  -- count(*) t�m rowlar� say demek. Burda count(product_id) de ayn� i�i g�r�r.
FROM production.products
GROUP BY 
		product_id  -- b�t�n product_id lerin product tablosunda birer kere ge�ti�ini g�rd�m.


SELECT product_id, COUNT(*) AS CNT_PRODUCT 
FROM production.products
GROUP BY 
		product_id
HAVING               
		COUNT(*) > 1  --HAVING�DE kulland���n s�tun Aggregate te kulland���n s�tun ismiyle ayn� olmal�. 

-- product_name e g�re yapal�m
SELECT product_name, COUNT(*) AS CNT_PRODUCT  -- count(*) t�m rowlar� say demek. Burda count(product_id) de ayn� i�i g�r�r.
FROM production.products
GROUP BY 
		product_name
HAVING 
		COUNT (*) > 1
-- a�a��daki gibi de kullanabiliriz.
SELECT product_name, COUNT(product_id) AS CNT_PRODUCT  -- count(*) t�m rowlar� say demek. count(product_id) de ayn� i�i g�r�r.
FROM production.products
GROUP BY 
		product_name
HAVING 
		COUNT (product_id) > 1

-- Bir sayma i�lemi bir grupland�rma, aggregate i�lemi yap�yorsan isimle de�il de ID ile yap.
-- Id ler birer defa ge�er. �simler tekrar edebilir. 

SELECT product_id, product_name, COUNT (*) CNT_PRODUCT
FROM production.products
GROUP BY
		product_name
HAVING 
		COUNT (*) > 1
-- select te yazd���n s�tunlar group by da olmas� gerekiyor. production_id group by da olmad��� i�in hata verdi.

SELECT product_id, product_name, COUNT (*) CNT_PRODUCT
FROM production.products
GROUP BY
		product_name, product_id
HAVING 
		COUNT (*) > 1


SELECT	product_id, COUNT (*) AS CNT_PRODUCT
FROM	production.products
GROUP BY
		product_id
HAVING
		COUNT (*) > 1


--GROUPING OPERATION SORU 2-- 
-- Write a query that returns category ids with a maximum list price above 4000 or a minimum list price below 500
--TR: Maksimum liste fiyat� 4000'in �zerinde veya minimum liste fiyat� 500'�n alt�nda olan kategori kimliklerini d�nd�ren bir sorgu yaz�n

SELECT category_id, MIN(list_price) AS min_price, MAX(list_price) AS max_price -- gruplad���m�z �ey category_id oldu�u i�in SELECT'te onu getiriyoruz
FROM production.products
-- ana tablo i�inde herhangi bir k�s�tlamam var m� yani where i�lemi var m�? yok. O zaman devam ediyorum
GROUP BY
		category_id
HAVING
		MIN(list_price) < 500 OR MAX(list_price) > 4000


--GROUPING OPERATION SORU 3-- 
-- Find the average product prices of the brands. TR: Markalar�n ortalama �r�n fiyatlar�n� bulun
-- As a result of the query, the average prices should be displayed in descending order.
--TR: Sorgu sonucunda ortalama fiyatlar azalan s�rada g�r�nt�lenmelidir.

SELECT A.brand_name, AVG(B.list_price) AS AVG_PRICE
FROM production.brands A, production.products B  
-- buradaki virg�l INNER JOIN ile ayn� i�i yap�yor! virg�lle beraber WHERE kullan�yoruz.
WHERE A.brand_id = B.brand_id
GROUP BY 
		A.brand_name
ORDER BY
		AVG_PRICE DESC

-- (virg�l + WHERE yerine--> INNER JOIN ile ��z�m)
SELECT A.brand_name, AVG(B.list_price) AS AVG_PRICE
FROM production.brands AS A
INNER JOIN production.products AS B
ON A.brand_id = B.brand_id
GROUP BY 
		A.brand_name
ORDER BY 
		AVG_PRICE DESC
-- ORDER BY 2 DESC olarak da yazabilirdik. Burada 2 --> SELECT'teki ikinci belirtilen veriyi temsil ediyor.


--GROUPING OPERATION SORU 4-- 
-- Write a query that returns BRANDS with an average product price more than 1000
-- TR: Ortalama �r�n fiyat� 1000'den fazla olan MARKALARI d�nd�ren bir sorgu yaz�n.

-- Virg�l + WHERE kullanarak ��z�m�:
SELECT A.brand_name, AVG(B.list_price) AS AVG_PRICE
FROM production.brands A, production.products B  
WHERE A.brand_id = B.brand_id
GROUP BY 
		A.brand_name
HAVING AVG(B.list_price) > 1000
ORDER BY
		2 DESC

-- INNER JOIN ile ��z�m�:
SELECT B.brand_name, AVG(list_price) as avg_price
FROM production.products as A
INNER JOIN production.brands as B
ON A.brand_id = B.brand_id
GROUP BY brand_name
HAVING AVG (list_price) > 1000
ORDER BY avg_price ASC;


--GROUPING OPERATION SORU 5-- 
--Write a query that returns the net price paid by the customer for each order. (Don't neglect discounts and quantities)
--TR: Her sipari� i�in m��terinin �dedi�i net fiyat� d�nd�ren bir sorgu yaz�n. (�ndirimleri ve miktarlar� ihmal etmeyin)

SELECT *, (quantity * list_price * (1-discount)) as net_price -- (list_price-list_price*discount) olarak da yaz�labilirdi.
FROM sales.order_items
-- bu query ile �nce her bir item_id i�in list_price ile indirim uygulanm�� net_price lar� g�r�yoruz.

-- order'larda birden fazla �r�n sipari� verilmi� oldu�unu g�rm��t�m. (order_id'lerin birden fazla item_id'leri var.)
-- O y�zden �r�nleri order_id olarak grupland�r�p her grup i�in toplama (SUM) yaparak
-- her order_id i�in TOPLAM net_price'� g�rm�� olaca��m.

SELECT order_id, SUM(quantity * list_price * (1-discount)) as net_price
FROM sales.order_items
GROUP BY 
		order_id



-------- CREATING SUMMARY TABLE INTO OUR EXISTING TABLE -------

SELECT *
INTO NEW_TABLE     -- INTO SATIRINDAK� TABLO �SM� �LE YEN� B�R TABLO OLU�TURUYORUZ.
FROM SOURCE_TABLE  -- FROM'DAN SONRASI KAYNAK TABLOMUZ
WHERE ...


SELECT C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year,
ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
-- brands tablosundan brand_name, categories tablosundan category_name, products tablosundan model_year
-- s�tunlar�n� se�iyoruz, bunlara indirim uygulanm�� net fiyatlar� yuvarlayarak ve total_sales_price ismi vererek
-- olu�turdu�umuz s�tunu ekliyoruz.
INTO sales.sales_summary  -- INTO ile bu sat�rda ismini belirledi�imiz "sales_summary" tablosunu olu�turuyoruz. Tablonun s�tunlar�n� SELECT sat�r�ncda belirledik.
FROM sales.order_items A, production.products B, production.brands C, production.categories D  --SELECT sat�r�nda se�ti�imiz s�tunlara ait tablolar.
WHERE A.product_id = B.product_id --A ile B'yi birle�tirdik.
AND B.brand_id = C.brand_id  -- B ile C'yi birle�tirdik
AND B.category_id = D.category_id --B ile D'yi birle�tirdik. Hepsi birle�mi� oldu.
GROUP BY
C.brand_name, D.category_name, B.model_year  --group by sat�r�nda grupland�rd���m�z s�tunlar SELECT'te aynen olmal�!!

--!!!! D�KKAT.. DAHA �NCE BU KOD �ALI�TIRILDI�I VE sales_summary �SM�NDE TABLO OLU�TURULDU�U ���N TEKRAR �ALI�TIRIRSAN HATA ALIRSIN!

SELECT *
FROM sales.sales_summary
ORDER BY 1,2,3


-- BUNDAN SONRA BU TABLOYU KULLANACA�IM!

----------- GROUPING SETS ----------

-- 1. Toplam sat�� miktar�n� hesaplay�n�z.
SELECT SUM(total_sales_price)
FROM sales.sales_summary

-- 2. Markalar�n toplam sat�� miktar�n� hesaplay�n�z.
SELECT Brand, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY 
		Brand

-- 3. Kategori baz�nda toplam sat�� miktar�n� hesaplay�n�z
SELECT Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY 
		Category

-- 4. Marka ve kategori k�r�l�mlar�ndaki toplam sales miktarlar�n� hesaplay�n�z
SELECT Brand, Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY 
		Brand, Category

--- �imdi bu i�lemleri GROUPING SETS y�ntemi ile yapal�m :---

SELECT brand, category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY
		GROUPING SETS(
						(Brand),
						(category),
						(brand, category),
						()      -- bo� parantez grupland�rma olmayan durumlar� getirir. 
						)
ORDER BY
		1, 2


------- ROLLUP VE CUBE ile GRUPLAMA------

-- ROLLUP, en ayr�nt�l�dan genel toplama kadar ihtiya� duyulan herhangi bir toplama d�zeyinde alt toplamlar olu�turur.
-- CUBE, ROLLUP�a benzer ama tek bir ifadenin t�m olas� alt toplam kombinasyonlar�n� hesaplamas�n� sa�lar


----- ROLLUP GRUPLAMA-----
SELECT
		d1,
		d2,
		d3, 
		aggregate_function
FROM
		table_name
GROUP BY
		ROLLUP (d1,d2,d3);

		-- �nce t�m s�tu�nlar� al�yor sonra sa�dan ba�layarak teker teker silerek her defas�nda yeniden bir gruplama yap�yor;
		-- �nce �� s�tuna g�re grupluyor, sonra sondakini at�p ilk 2 s�tuna g�re grupluyor
		-- sonra sondakini yine at�p ilk s�tuna g�re grupluyor
		-- sonra hi� gruplam�yor.-- 

SELECT brand, category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY
		ROLLUP (Brand, Category)
ORDER BY
		1,2
		;


------ CUBE GRUPLAMA--------
SELECT
		d1,
		d2,
		d3, 
		aggregate_function
FROM
		table_name
GROUP BY
		CUBE (d1,d2,d3);

--- �nce �nce �� s�tunu birden grupluyor.
-- sonra kalanlar� 2'�er 2'�er 3 defa gruplama yap�yor.
-- sonra kalanlar� teker teker grupluyor.
-- en son gruplam�yor.

SELECT brand, category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY
		CUBE (Brand, Category)
ORDER BY
		1,2
		;