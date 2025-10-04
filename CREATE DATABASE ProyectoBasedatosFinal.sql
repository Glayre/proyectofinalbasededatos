CREATE DATABASE Proyectobasedatosfinal;
USE ProyectoBasedatosFinal;

# Tabla usuarios
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    edad INT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

#Tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

#Tabla compras
CREATE TABLE compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    total DECIMAL(10,2) NOT NULL CHECK (total > 0),
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

#Tabla detalle_compras
CREATE TABLE detalle_compras (
    id INT AUTO_INCREMENT PRIMARY KEY,
    compra_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal > 0),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (compra_id) REFERENCES compras(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

#Insertar usuarios
INSERT INTO usuarios (nombre, email, edad) VALUES
('Olga Perez', 'olgaperez@email.com', 43),
('Keyla Vargas', 'keylavargas@email.com', 45),
('Tatiana Hernandez', 'tatianahernandez@email.com', 48),
('Maria Cagadan', 'mariacadagan@email.com', 43),
('Estefania Del Nogal', 'estefaniadelnogal@email.com', 31);

#Insertar productos
INSERT INTO productos (nombre, descripcion, precio, stock) VALUES
('Laptop', 'Laptop hp', 1200.00, 10),
('Mouse', 'Mouse inalambrico', 25.50, 20),
('Teclado', 'Teclado mecanico', 75.00, 30),
('Monitor', 'Monitor 24 pulgadas', 200.00, 20),
('Audifonos', 'Audifonos inalambrico', 20.00, 20);

#Insertar compras
INSERT INTO compras (usuario_id, total) VALUES
(1, 1250.00), (2, 300.00), (3, 75.00), (4, 400.00), (5, 150.00),
(1, 200.00), (2, 150.00), (3, 1200.00), (4, 25.50), (5, 75.00);

#Insertar detalle_compras
INSERT INTO detalle_compras (compra_id, producto_id, cantidad, subtotal) VALUES
(1, 1, 1, 1200.00), (1, 2, 2, 50.00),
(2, 4, 1, 200.00), (2, 5, 1, 100.00),
(3, 3, 1, 75.00), (4, 4, 2, 400.00),
(5, 5, 1, 150.00), (6, 4, 1, 200.00),
(7, 5, 1, 150.00), (8, 1, 1, 1200.00),
(9, 2, 1, 25.50), (10, 3, 1, 75.00),
(2, 2, 1, 25.50), (4, 2, 1, 25.50),
(6, 2, 1, 25.50), (8, 2, 1, 25.50),
(10, 2, 1, 25.50), (1, 3, 1, 75.00),
(3, 2, 1, 25.50), (5, 2, 1, 25.50);
