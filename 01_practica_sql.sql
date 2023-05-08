--Obtener todos los registros y todos los campos de la tabla de productos
SELECT * FROM products;

-- Obtenerr una consulta con Productid, productname, supplierid, categoryId, UnistsinStock, UnitPrice
SELECT product_id, product_name,supplier_id, category_id,units_in_stock FROM products;

--Crear una consulta para obtener el IdOrden, IdCustomer, Fecha de la orden de la tabla de ordenes.

SELECT order_id, customer_id, order_date FROM orders;

--Crear una consulta para obtener el OrderId, EmployeeId, Fecha de la orden.

SELECT order_id, employee_id, order_date FROM orders;
--Columnas calculadas 

--Obtener una consulta con Productid, productname y valor del inventario, valor inventrio (UnitsinStock * UnitPrice)

SELECT product_id, product_name, (units_in_stock*unit_price) as valor_inventario FROM products;

-- Cuanto vale el punto de reorden 

SELECT (unit_price * reorder_level) as punto_reorden FROM products;

-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe estar en mayuscula 

SELECT product_id,UPPER(product_name)unit_price FROM products;

-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres */

SELECT product_id,product_name,unit_price FROM products WHERE LENGTH(product_name)=10;
-- SELECT product_id,product_name,unit_price  SUBCSTRING product_name,1,10) from products

--Obtenre una consulta que muestre la longitud del nombre del producto

SELECT LENGTH(product_name) FROM products;

--Obtener una consulta de la tabla de productos que muestre el nombre en minúscula

SELECT LOWER(product_name) FROM products;

-- Mostrar una consulta con Productid, productname y precio, el nombre del producto debe contener unicamente 10 caracteres y se deben mostrar en mayúscula */

--SELECT product_id,UPPER(product_name), unit_price FROM products WHERE LENGTH(product_name)=10;

select product_id, UPPER(substring(product_name,1,10)), unit_price from products
--Filtros

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais Obtener los clientes cuyo pais sea Spain

SELECT customer_id,company_name,country FROM customers  WHERE country='Spain';

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U

SELECT customer_id,company_name,country FROM customers WHERE country LIKE 'U%';

--Obtener de la tabla de Customers las columnas CustomerId, CompanyName, Pais, Obtener los clientes cuyo pais comience con la letra U,S,A

SELECT customer_id,company_name,country FROM customers WHERE country LIKE 'U%' OR country LIKE 'S%' OR country LIKE 'A%';

--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice cuyos precios esten entre 50 y 150

SELECT product_id,product_name,unit_price FROM products WHERE unit_price BETWEEN 50 AND 150;

--Obtener de la tabla de Productos las columnas productid, ProductName, UnitPrice, UnitsInStock cuyas existencias esten entre 50 y 100

SELECT product_id,product_name,unit_price,units_in_stock FROM products WHERE units_in_stock BETWEEN 50 AND 150;

--Obtener las columnas OrderId, CustomerId, employeeid de la tabla de ordenes cuyos empleados sean 1, 4, 9

SELECT order_id,customer_id,employee_id FROM orders WHERE employee_id IN(1,4,9);

-- ORDENAR EL RESULTADO DE LA QUERY POR ALGUNA COLUMNA 

--Obtener la información de la tabla de Products, Ordenarlos por Nombre del Producto de forma ascendente

SELECT * FROM products ORDER BY product_name ASC;

-- Obtener la información de la tabla de Products, Ordenarlos por Categoria de forma ascendente y por precio unitario de forma descendente

SELECT * FROM products ORDER BY category_id ASC,unit_price DESC;

-- Obtener la información de la tabla de Clientes, Customerid, CompanyName, city, country ordenar por pais, ciudad de forma ascendente

SELECT customer_id,company_name,city,country FROM customers  ORDER BY country, city;

-- Obtener los productos productid, productname, categoryid, supplierid ordenar por categoryid y supplier únicamente mostrar aquellos cuyo precio esté entre 25 y 200
SELECT product_id,product_name,category_id,supplier_id 
FROM products WHERE unit_price BETWEEN 25 AND 200 ORDER BY category_id, supplier_id;

--Funciones agregación

--Cuantos productos hay en la tabla de productos
SELECT count (product_id) FROM products;

--de la tabla de productos Sumar las cantidades en existencia 

SELECT sum(units_in_stock) FROM products;

--Promedio de los precios de la tabla de productos

SELECT avg(unit_price) FROM products;

--Ordenar

--Obtener los datos de productos ordenados descendentemente por precio unitario de la categoría 1
SELECT * FROM products WHERE category_id =1 ORDER BY unit_price DESC;

--Obtener los datos de los clientes(Customers) ordenados descendentemente por nombre(CompanyName) que se encuentren en la ciudad(city) de barcelona, Lisboa

SELECT * FROM customers WHERE city LIKE 'Barcelona' or city LIKE 'Lisboa' ORDER BY company_name DESC;
SELECT * FROM customers WHERE city in('Barcelona','Lisboa') ORDER BY company_name DESC;
--Obtener los datos de las ordenes, ordenados descendentemente por la fecha de la orden cuyo cliente(CustomerId) sea ALFKI

SELECT * FROM orders WHERE customer_id= 'ALFKI' ORDER BY order_date DESC;

--Obtener los datos del detalle de ordenes, ordenados ascendentemente por precio cuyo producto sea 1, 5 o 20

SELECT * FROM order_details WHERE product_id IN(1,5,20) ORDER BY unit_price ASC;

--Obtener los datos de las ordenes ordenados ascendentemente por la fecha de la orden cuyo empleado sea 2 o 4

SELECT * FROM orders WHERE employee_id IN(2,4) ORDER BY order_date ASC;

--Obtener los productos cuyo precio están entre 30 y 60 ordenado por nombre

SELECT * FROM  products WHERE unit_price BETWEEN 30 and 60 ORDER BY product_name;

--funciones de agrupacion
--OBTENER EL MAXIMO, MINIMO Y PROMEDIO DE PRECIO UNITARIO DE LA TABLA DE PRODUCTOS UTILIZANDO ALIAS

SELECT max(unit_price) as precio_maximo, min(unit_price) as precio_minimo, avg(unit_price) precio_promedio FROM products;

--Agrupacion
--Numero de productos por categoria

SELECT count(*) as num_productos FROM products GROUP BY category_id;
SELECT categoria_id, count(produc_id) as num_product FROM products GROUP BY category_id ORDER BY num_product;
--Obtener el precio promedio por proveedor de la tabla de productos

SELECT avg(unit_price) as precio_promedio FROM products GROUP BY supplier_id;

--Obtener la suma de inventario (UnitsInStock) por SupplierID De la tabla de productos (Products)

SELECT sum(units_in_stock) as suma_inventario FROM products GROUP BY supplier_id;

--Contar las ordenes por cliente de la tabla de orders

SELECT  count (*) as num_ordenes FROM orders GROUP BY customer_id;

--Contar las ordenes por empleado de la tabla de ordenes unicamente del empleado 1,3,5,6

SELECT employee_id, count(order_id) as num_ordenes FROM orders WHERE employee_id IN(1,3,5,6) GROUP BY employee_id ;

--Obtener la suma del envío (freight) por cliente
SELECT customer_id, sum(freight) as suma_envio FROM orders GROUP BY customer_id;

--De la tabla de ordenes únicamente de los registros cuya ShipCity sea Madrid, Sevilla, Barcelona, Lisboa, London Ordenado por el campo de suma del envío

SELECT ship_city FROM orders
WHERE ship_city IN('Madrid','Sevilla','Barcelona','Lisboa','London')
GROUP BY order_id ORDER BY sum(freight) 

SELECT ship_city FROM orders
WHERE ship_city IN('Madrid','Sevilla','Barcelona','Lisboa','London')
GROUP BY order_id ORDER BY sum(freight) 

--Obtener el precio promedio de los productos por categoria sin contar con los productos descontinuados (Discontinued)

SELECT category_id,AVG(unit_price) FROM products WHERE discontinued=0  GROUP BY category_id

--Obtener la cantidad de productos por categoria,  aquellos cuyo precio se encuentre entre 10 y 60 que tengan más de 12 productos
SELECT category_id
count(product_id) as cantidad 
FROM products
where  unit_price 
between  10 and 60 group by  category_id having count (product_id)>=9

--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16.
SELECT category_id 
sum(units_in_stock) 
FROM products 
WHERE supplier_id IN(17,19,16) GROUP BY category_id
--cuya categoria tenga menos de 100 unidades ordenado por unidades
SELECT category_id,
sum(units_in_stock) as unidades 
FROM products 
group by category_id 
having sum (units_in_stock)<200
order by unidades;


--distinct

-- Se quiere saber a qué paises se les vende usar la tabla de clientes
SELECT DISTINCT country FROM customers;
-- Se quiere saber a qué ciudades se les vende usar la tabla de clientes
SELECT DISTINCT city FROM customers;
-- Se quiere saber a qué ciudades se les ha enviado una orden
SELECT DISTINCT ship_city FROM orders;
--Se quiere saber a qué ciudades se les vende en el pais USA usar la tabla de clientes
SELECT DISTINCT city FROM customers WHERE country='USA';

--Agrupacion

-- Se quiere saber a qué paises se les vende usar la tabla de clientes nota hacerla usando group by
SELECT  country FROM customers group by country;
--Cuantos clientes hay por pais
SELECT country 
count(customer_id) as num_clientes 
FROM customers 
GROUP BY country;
--Cuantos clientes hay por ciudad en el pais USA
SELECT country,city
count(customer_id) as cantidad 
FROM customer 
WHERE country= 'USA' 
GROUP BY city;
--Cuantos productos hay por proveedor de la categoria 1
SELECT supplier_id, 
count(product_id) as cantidad 
FROM products
WHERE category_id=1 
GROUP BY supplier_id

--Filtro con having

-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos
SELECT supplier_id, 
count(product_id) as cantidad 
FROM products 
GROUP BY supplier_id 
HAVING count(*)>1
-- Cuales son los proveedores que nos surten más de 1 producto, mostrar el proveedor mostrar la cantidad de productos, pero únicamente de la categoria 1
SELECT supplier_id,
count(producto_id) as cantidad_producto
FROM products 
WHERE category_id=1
GROUP BY supplier_id
HAVING count(*)>1
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES USA, CANADA, SPAIN (ShipCountry) 
--MOSTRAR UNICAMENTE LOS EMPLEADOS CUYO CONTADOR DE ORDENES SEA MAYOR A 20
SELECT employee_id,
count(order_id) as cantidad_order
FROM orders
WHERE ship_country 
GROUP BY employee_id
HAVING count(*>20)
--OBTENER EL PRECIO PROMEDIO DE LOS PRODUCTOS POR PROVEEDOR UNICAMENTE DE AQUELLOS CUYO PROMEDIO SEA MAYOR A 20
SELECT supplier_id, AVG(unit_price) as media_precio
FROM products
GROUP BY supplier_id
HAVING AVG(unit_price) > 20;
--OBTENER LA SUMA DE LAS UNIDADES EN EXISTENCIA (UnitsInStock) POR CATEGORIA, Y TOMANDO EN CUENTA UNICAMENTE LOS PRODUCTOS CUYO PROVEEDOR (SupplierID) SEA IGUAL A 17, 19, 16 DICIONALMENTE CUYA SUMA POR CATEGORIA SEA MAYOR A 300--
SELECT category_id, SUM(units_in_stock) as suma_unidades
FROM products
WHERE supplier_id IN (16, 17, 19)
GROUP BY category_id
HAVING SUM(units_in_stock) > 300;
--CONTAR LAS ORDENES POR EMPLEADO DE LOS PAISES (ShipCountry) SA, CANADA, SPAIN cuYO CONTADOR SEA MAYOR A 25
SELECT category_id, SUM(units_in_stock) as suma_unidades
FROM products
WHERE supplier_id IN (16, 17, 19)
GROUP BY category_id
HAVING SUM(units_in_stock) > 300;
----OBTENER LAS VENTAS (Quantity * UnitPrice) AGRUPADAS POR PRODUCTO (Orders details) Y CUYA SUMA DE VENTAS SEA MAYOR A 50.000
SELECT product_id, SUM(quantity * unit_price) as ventas_totales
FROM order_details
GROUP BY product_id
HAVING SUM(quantity * unit_price) > 50000;

--Mas de una tabla 

--OBTENER EL NUMERO DE ORDEN, EL ID EMPLEADO, NOMBRE Y APELLIDO DE LAS TABLAS DE ORDENES Y EMPLEADOS
SELECT o.order_id, e.employee_id, e.first_name, e.last_name
FROM orders o
JOIN employees e ON o.employee_id = e.employee_id;
--OBTENER EL PRODUCTID, PRODUCTNAME, SUPPLIERID, COMPANYNAME DE LAS TABLAS DE PRODUCTOS Y PROVEEDORES (SUPPLIERS)
SELECT products.product_id, products.product_name, products.supplier_id, suppliers.company_name
FROM products
INNER JOIN suppliers
ON products.supplier_id = suppliers.supplier_id;
--OBTENER LOS DATOS DEL DETALLE DE ORDENES CON EL NOMBRE DEL PRODUCTO DE LAS TABLAS DE DETALLE DE ORDENES Y DE PRODUCTOS
SELECT od.order_id, od.product_id, p.product_name, od.unit_price, od.quantity, od.discount
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id;
--OBTENER DE LAS ORDENES EL ID, SHIPPERID, NOMBRE DE LA COMPAÑÍA DE ENVIO (SHIPPERS)
SELECT orders.order_id, orders.ship_via AS shipper_id, shippers.company_name
FROM orders
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id;
--Obtener el número de orden, país de envío (shipCountry) y el nombre del empleado de la tabla ordenes y empleados Queremos que salga el Nombre y Apellido del Empleado en una sola columna.
SELECT o.order_id, o.ship_country, CONCAT(e.first_name, ' ', e.last_name) as nombre_completo_empleado
FROM orders o
INNER JOIN employees e ON o.employee_id = e.employee_id;
--Combinando la mayoría de conceptos

--CONTAR EL NUMERO DE ORDENES POR EMPLEADO OBTENIENDO EL ID EMPLEADO Y EL NOMBRE COMPLETO DE LAS TABLAS DE ORDENES Y DE EMPLEADOS join y group by / columna calculada
SELECT e.employee_id, CONCAT(e.first_name, ' ', e.last_name) AS nombre_completo_empleado, COUNT(o.order_id) AS numero_ordenes
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, nombre_completo_empleado;
--OBTENER LA SUMA DE LA CANTIDAD VENDIDA Y EL PRECIO PROMEDIO POR NOMBRE DE PRODUCTO DE LA TABLA DE ORDERS DETAILS Y PRODUCTS
SELECT p.product_name, SUM(od.quantity) AS cantidad_vendida, AVG(od.unit_price) AS precio_promedio
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_name;
--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR CLIENTE DE LAS TABLAS ORDER DETAILS, ORDERS
SELECT o.customer_id, SUM(od.unit_price * od.quantity) AS ventas
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.customer_id;
--OBTENER LAS VENTAS (UNITPRICE * QUANTITY) POR EMPLEADO MOSTRANDO EL APELLIDO (LASTNAME)DE LAS TABLAS EMPLEADOS, ORDENES, DETALLE DE ORDENES
SELECT e.last_name AS apellido, SUM(od.unit_price * od.quantity) AS ventas
FROM employees e
JOIN orders o ON e.employee_id = o.employee_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.last_name;




