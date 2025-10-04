proyectofinalbasededatos
--Consultas SQL para el proyecto final de base de datos

-- Lista todos los usuarios registrados
SELECT * FROM usuarios;

-- Productos disponibles en stock
SELECT * FROM productos WHERE stock > 0;

-- Productos cuyo precio sea mayor a 50
SELECT * FROM productos WHERE precio > 50;

-- Usuario más joven y más mayor
SELECT * FROM usuarios ORDER BY edad ASC LIMIT 1;
SELECT * FROM usuarios ORDER BY edad DESC LIMIT 1;

-- Actualiza la edad del usuario más mayor
UPDATE usuarios SET edad = edad + 1 WHERE id = (
    SELECT id FROM usuarios ORDER BY edad DESC LIMIT 1
);

-- Compras con datos del usuario
SELECT c.id, u.nombre, u.email, c.total, c.fecha_compra
FROM compras c
JOIN usuarios u ON c.usuario_id = u.id;

-- Compras con productos comprados
SELECT c.id AS compra_id, u.nombre AS usuario, p.nombre AS producto, dc.cantidad, dc.subtotal
FROM detalle_compras dc
JOIN compras c ON dc.compra_id = c.id
JOIN usuarios u ON c.usuario_id = u.id
JOIN productos p ON dc.producto_id = p.id;

-- Productos ordenados por precio descendente
SELECT * FROM productos ORDER BY precio DESC;

-- Cantidad total de productos comprados por cada usuario
SELECT u.nombre, SUM(dc.cantidad) AS total_productos
FROM usuarios u
JOIN compras c ON u.id = c.usuario_id
JOIN detalle_compras dc ON c.id = dc.compra_id
GROUP BY u.id;

-- Producto más vendido
SELECT p.nombre, SUM(dc.cantidad) AS total_vendido
FROM productos p
JOIN detalle_compras dc ON p.id = dc.producto_id
GROUP BY p.id
ORDER BY total_vendido DESC
LIMIT 1;

-- Usuario que ha gastado más dinero
SELECT u.nombre, SUM(c.total) AS total_gastado
FROM usuarios u
JOIN compras c ON u.id = c.usuario_id
GROUP BY u.id
ORDER BY total_gastado DESC
LIMIT 1;

-- Usuarios ordenados por total gastado
SELECT u.nombre, SUM(c.total) AS total_gastado
FROM usuarios u
JOIN compras c ON u.id = c.usuario_id
GROUP BY u.id
ORDER BY total_gastado DESC;

-- Total de ingresos generados
SELECT SUM(total) AS ingresos_totales FROM compras;

-- Productos comprados más de una vez
SELECT p.nombre, COUNT(dc.id) AS veces_comprado
FROM productos p
JOIN detalle_compras dc ON p.id = dc.producto_id
GROUP BY p.id
HAVING veces_comprado > 1;

-- Eliminar la compra con el monto más bajo
DELETE FROM compras
WHERE id = (
    SELECT id FROM compras ORDER BY total ASC LIMIT 1
);

-- Eliminar usuarios sin compras
DELETE FROM usuarios
WHERE id NOT IN (SELECT DISTINCT usuario_id FROM compras);

-- Nombre del usuario y cantidad de compras realizadas
SELECT u.nombre, COUNT(c.id) AS compras_realizadas
FROM usuarios u
JOIN compras c ON u.id = c.usuario_id
GROUP BY u.id;

-- Productos con cantidad de veces comprados
SELECT p.nombre, COUNT(dc.id) AS veces_comprado
FROM productos p
JOIN detalle_compras dc ON p.id = dc.producto_id
GROUP BY p.id;

-- Producto más caro comprado por cada usuario
SELECT u.nombre, MAX(p.precio) AS producto_mas_caro
FROM usuarios u
JOIN compras c ON u.id = c.usuario_id
JOIN detalle_compras dc ON c.id = dc.compra_id
JOIN productos p ON dc.producto_id = p.id
GROUP BY u.id;

