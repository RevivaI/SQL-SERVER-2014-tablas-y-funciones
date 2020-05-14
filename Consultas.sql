IF OBJECT_ID ('buscarporcliente','P') IS NOT NULL
   DROP PROCEDURE buscarporcliente;
GO
CREATE PROCEDURE buscarporcliente (@CodClie VARCHAR(25))
AS
BEGIN
   DECLARE @AUX INT;
   IF EXISTS(SELECT * FROM Cliente WHERE nombre_instagram = @CodClie)
     BEGIN
	   SET @AUX = 1;
	   IF EXISTS(SELECT * FROM Pedido WHERE nombre_instagram=@CodClie)
	     BEGIN
           SELECT 
		      Cliente.nombre_completo AS nombrecompleto,
			  Cliente.rut             AS rut,
			  Cliente.telefono        AS telefono,
		      Pedido.codigo_pedido    AS codigopedido,
			  Pedido.fecha_ingreso    AS fechaingreso,
			  Pedido.direccion_envio  AS direcciondeenvio,
			  Pedido.fecha_pago       AS fechadepago,
              Metodo_entrega.codigo_metodo_entrega AS metododeentrega		   
		   FROM 
			  Pedido,
			  Cliente,
			  Metodo_entrega		    
	     END
	   ELSE
	     BEGIN
		  SET @AUX = -2;
	     END
	 END
   ELSE
     BEGIN
	   SET @AUX = -1;
 	 END
  RETURN @AUX;
END
GO

IF OBJECT_ID ('buscarporpedido','P') IS NOT NULL
   DROP PROCEDURE buscarporpedido;
GO
CREATE PROCEDURE buscarporpedido (@CodPed VARCHAR(10))
AS
BEGIN
   DECLARE @AUX INT;
   IF EXISTS(SELECT * FROM Pedido WHERE codigo_pedido = @CodPed)
     BEGIN
	   SET @AUX = 1;
           SELECT
		      Cliente.nombre_instagram AS nombreinstagram,
		      Cliente.nombre_completo  AS nombrecompleto,
			  Cliente.rut              AS rut,
			  Cliente.telefono         AS telefono,
			  Pedido.fecha_ingreso     AS fechaingreso,
			  Pedido.direccion_envio   AS direcciondeenvio,
			  Pedido.fecha_pago        AS fechadepago,
			  Producto.codigo_producto AS codigoproducto,
			  Tipo_Prenda.codigo_tipo_prenda AS codigotipoprenda
		   FROM 
			  Pedido,
			  Cliente,
			  Producto,
			  Tipo_Prenda		    
	 END
   ELSE
     BEGIN
	   SET @AUX = -1;
 	 END
  RETURN @AUX;
END
GO

IF OBJECT_ID ('listarpedidosentreIngreso','P') IS NOT NULL
   DROP PROCEDURE listarpedidosentreIngreso;
GO
CREATE PROCEDURE listarpedidosentreIngreso(@fecha_inicio DATETIME, @fecha_fin DATETIME)
AS
BEGIN
  SELECT  
   Pedido.codigo_pedido AS codigopedido
  FROM 
   Pedido
  WHERE fecha_ingreso BETWEEN @fecha_inicio AND @fecha_fin;
END
GO

IF OBJECT_ID ('buscarporproducto','P') IS NOT NULL
   DROP PROCEDURE buscarporproducto;
GO
CREATE PROCEDURE buscarporproducto (@CodProd VARCHAR(10))
AS
BEGIN
   DECLARE @AUX INT;
   IF EXISTS(SELECT * FROM Detalle_Pedido WHERE codigo_producto = @CodProd)
     BEGIN
	   SET @AUX = 1;
           SELECT
		     Detalle_Pedido.codigo_pedido AS codigopedido
		   FROM 
			 Detalle_Pedido		    
	 END
   ELSE
     BEGIN
	   SET @AUX = -1;
 	 END
  RETURN @AUX;
END
GO

IF OBJECT_ID ('ganaciasentre','P') IS NOT NULL
   DROP PROCEDURE gananciasentre;
GO
CREATE PROCEDURE gananciasentre(@fecha_inicio DATETIME, @fecha_fin DATETIME)
AS
BEGIN
  DECLARE @ganancia INT  
   SET @ganancia = (SELECT SUM((Producto.precio_producto-Producto.costo_produccion)*Detalle_Pedido.cantidad)
					FROM 
                      Detalle_Pedido,
                      Producto,
					  Pedido
                    WHERE Pedido.fecha_ingreso BETWEEN @fecha_inicio AND @fecha_fin);

  RETURN @ganancia;
END
GO
