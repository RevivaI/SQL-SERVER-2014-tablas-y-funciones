CREATE TABLE Cliente_Pedido(
  nombre_instagram VARCHAR(25),
  codigo_pedido VARCHAR(10),
  FOREIGN KEY (nombre_instagram) REFERENCES Cliente(nombre_instagram),
  FOREIGN KEY (codigo_pedido) REFERENCES Pedido(codigo_pedido)
);

CREATE TABLE Producto_Pedido(
  codigo_producto VARCHAR(10),
  codigo_pedido VARCHAR(10),
  FOREIGN KEY (codigo_producto) REFERENCES Producto(codigo_producto),
  FOREIGN KEY (codigo_pedido) REFERENCES Pedido(codigo_pedido)
);
