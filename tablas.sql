USE Master
IF EXISTS (Select 1 From sys.databases where Name=N'Bendise')DROP DATABASE Bendise;
CREATE DATABASE Bendise;
USE Bendise;

Create Table Cliente(
   nombre_instagram VARCHAR(25) PRIMARY KEY,
   rut              VARCHAR(30),
   nombre_completo  VARCHAR(30),
   telefono         VARCHAR(15)   
);

Create Table Color(
   codigo_color        VARCHAR(10) PRIMARY KEY,
   descripcion_color   VARCHAR(30)
);

Create Table Tipo_Tela(
  codigo_tipo_tela      VARCHAR(10) PRIMARY KEY,
  descripcion_tipo_tela VARCHAR(30)  
);

Create Table Talla(
  codigo_talla          VARCHAR(10) PRIMARY KEY,
  descripcion_talla     VARCHAR(30)
);

Create Table Tipo_Prenda(
  codigo_tipo_prenda      VARCHAR(10) PRIMARY KEY,
  descripcion_tipo_prenda VARCHAR(30),
  codigo_tipo_tela        VARCHAR(10), 
  codigo_color            VARCHAR(10), 
  FOREIGN KEY (codigo_tipo_tela) REFERENCES Tipo_Tela(codigo_tipo_tela),
  FOREIGN KEY   (codigo_color)   REFERENCES Color(codigo_color)
);

Create Table Producto(
  codigo_producto    VARCHAR(10) PRIMARY KEY,
  codigo_tipo_prenda VARCHAR(10), 
  codigo_talla       VARCHAR(10),  
  precio_producto    INT NOT NULL,
  costo_produccion   INT NOT NULL,
  FOREIGN KEY    (codigo_talla)    REFERENCES Talla(codigo_talla),
  FOREIGN KEY (codigo_tipo_prenda) REFERENCES Tipo_Prenda(codigo_tipo_prenda)
);

Create Table Estado_Pedido(
  codigo_estado_pedido      VARCHAR(10) PRIMARY KEY,
  descripcion_estado_pedido VARCHAR(30)
);

Create Table Metodo_entrega(
  codigo_metodo_entrega      VARCHAR(10) PRIMARY KEY,
  descripcion_metodo_entrega VARCHAR(30)
);

Create Table Pedido(
  codigo_pedido INT PRIMARY KEY IDENTITY(1,1),  --IDENTITY IDENTIFICA COMO CODIGO NUMEROS ENTEROS DE 1 EN 1 A MEDIDA QUE SE AGREGAN NUEVOS DATOS
  nombre_instagram VARCHAR(25),
  codigo_metodo_entrega VARCHAR(10),
  codigo_estado_pedido VARCHAR(10),
  fecha_ingreso DATETIME,
  fecha_pago DATETIME,
  direccion_envio VARCHAR(50),
  FOREIGN KEY (nombre_instagram) REFERENCES Cliente(nombre_instagram),
  FOREIGN KEY (codigo_metodo_entrega) REFERENCES Metodo_Entrega(codigo_metodo_entrega),
  FOREIGN KEY (codigo_estado_pedido) REFERENCES Estado_Pedido(codigo_estado_pedido)
);

Create Table Detalle_Pedido(
  codigo_detalle_pedido VARCHAR(10) PRIMARY KEY,
  codigo_producto       VARCHAR(10),
  codigo_pedido         INT,
  cantidad              INT NOT NULL,
  FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto),
  FOREIGN KEY (codigo_pedido)   REFERENCES Pedido(codigo_pedido)
);
