-- CONSULTAR TODA A TABELA DE PRODUTOS 1

SELECT
		productCode
		,productName
		,productline
        ,productScale
        ,productVendor
        ,productDescription
        ,quantityInStock
        ,buyPrice
        ,MSRP
FROM products


;
-- CONSULTAR TODA A TABELA DE CLIENTES 2

SELECT 
*
FROM customers
												
;
-- LINHAS DE PRODUTOS 3

SELECT 
*
FROM PRODUCTLINES	

;
-- EMPREGADOS 4
SELECT 
*
FROM employees

;
-- ESCRITORIOS 5
SELECT 
*
FROM OFFICES

;
-- DETALHES DO PEDIDOS 6
SELECT 
*
FROM orderdetails

;
-- LISTA DE PEDIDOS 7

SELECT 
*
FROM orders

;

-- LISTA DE PEDIDOS 8

SELECT 
*
FROM payments

;
-- LEFT JOIN COM A TABELA DE DESCRIÇÃO DAS LINHAS DOS PRODUTOS 9
SELECT 
A.*
,b.textDescription
,b.htmlDescription
,b.image
FROM PRODUCTS A
LEFT JOIN productlines B
ON A.productLine=B.productLine
;

-- INNER JOIN COM A TABELA DE DESCRIÇÃO DAS LINHAS DOS PRODUTOS 10 (intersecção )
SELECT 
A.*
,b.textDescription
,b.htmlDescription
,b.image
FROM PRODUCTS A
INNER JOIN productlines B
ON A.productLine=B.productLine


;


-- LISTA TODOS AS LINHAS DE PRODUTOS DISTINTOS 11
SELECT DISTINCT
productline
FROM PRODUCTS
;

-- LISTA TODOS AS LINHAS DE PRODUTOS E SUAS QUANTIDADES 12
SELECT 
productline,
count(*)
FROM PRODUCTS
group by 1

;
-- LISTA TODOS AS LINHAS DE PRODUTOS E SUAS QUANTIDADES COM SUBQUERY 13
SELECT 
productline,
count(*) as qtde
FROM (SELECT productCode,productline FROM PRODUCTS)
group by 1
;

-- LISTA DE TODOS OS CODIGOS DE CLIENTES 14
SELECT DISTINCT
customerNumber
FROM customers
;
-- LISTA DE TODOS OS PEDIDOS COM A LISTA DE CLIENTE 15
SELECT 
a.*
,b.orderNumber
,b.orderDate
,b.requiredDate
,b.shippedDate
,b.status
,b.comments

FROM customers a
right JOIN ORDERS b
on a.customerNumber=b.customerNumber

;
-- ORDENA OS PEDIDOS POR ORDEM CRESCENTE  DATA 16
SELECT
*
FROM orders
ORDER BY ORDERDATE 
;
-- ORDENA OS PEDIDOS POR ORDEM DECRESCENTE DA DATA 17
SELECT
*
FROM orders
ORDER BY ORDERDATE DESC
;
-- ORDENA OS PEDIDOS POR ORDEM CRESCENTE DA DATA E APÓS POR ORDEM ALFABETICA DO CLIENTE 18
SELECT
A.*
,B.customerName
FROM orders A
LEFT JOIN customers B
on a.customerNumber=b.customerNumber 
ORDER BY A.ORDERDATE, customerName
;
--  CONTA A QUANTIDADE DE PEDIDOS FEITOS E A QUANTIDADE DE PEDIDOS EM 2022 19
SELECT  
customerNumber
,COUNT(orderNumber) AS QTDE_PEDIDOS
,COUNT( CASE WHEN EXTRACT(YEAR FROM orderDate)=2022 THEN orderNumber END) AS QTDE_PEDIDOS_2022

FROM orders 
GROUP BY 1
;
-- SELECIONA OS DADOS DOS CLIENTES E DIZ A QUANTIDADE DE PEDIDOS POR CLIENTE E NO ANO 2022 20
SELECT 
A.*
,B. QTDE_PEDIDOS
,B. QTDE_PEDIDOS_2022
FROM CUSTOMERS  A
LEFT JOIN (
			SELECT  
			customerNumber
			,COUNT(orderNumber) AS QTDE_PEDIDOS
			,COUNT( CASE WHEN EXTRACT(YEAR FROM orderDate)=2022 THEN orderNumber END) AS QTDE_PEDIDOS_2022

			FROM orders 
			GROUP BY 1) B
on A.customerNumber=B.customerNumber 

;
--  JUNTANDO O NOME E O SOBRENOME DO FUNCIONARIO 21
SELECT 
employeeNumber
,firstName||' '|| lastName AS NOME_FUNCIONARIO
FROM employees
;
-- QUANTIDADE DE FUNCIONARIOS EM CADA ESCRITORIO 22
SELECT 
officeCode
,COUNT(DISTINCT employeeNumber) AS QTDE
FROM employees
group by 1
;
-- QUANTIDADE DE ESCRITORIOS EM CADA ESTADO 23
SELECT 
state
,COUNT(DISTINCT officeCode)
FROM offices
group by 1
;
-- QUANTIDADE DE CLIENTES EM CADA CIDADE/ESTADO 24

SELECT 
state
,city
,COUNT(DISTINCT customerNumber)
FROM customers
GROUP BY 1,2

;

-- QUANTIDADE DE CLIENTES POR EMPREGADO 25
SELECT 
A.*,
B.QTDE_CLIENTES
FROM employees A 
LEFT JOIN (
			SELECT 
			salesRepEmployeeNumber
			,COUNT(DISTINCT customerNumber) AS QTDE_CLIENTES
			FROM customers
			GROUP BY 1
            ) B
ON A.employeeNumber=B.salesRepEmployeeNumber
;
            
--  QUANTIDADE DE ENCOMENDAS NÃO ENVIADAS 26
SELECT 
customerNumber
,COUNT( CASE WHEN shippedDate IS NULL THEN orderNumber END) AS QTDE_NAO_ENVIADA
,COUNT( CASE WHEN shippedDate IS NOT NULL THEN orderNumber END) AS QTDE_ENVIADA

FROM orders
group by 1

;
-- total pago por cliente 27

SELECT 
customerNumber,
sum(amount) as total_pago
FROM payments
group by 1

