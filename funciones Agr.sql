IF OBJECT_ID ('agregarpedidoacliente','P') IS NOT NULL
   DROP PROCEDURE agregarpedidoacliente;
GO
CREATE PROCEDURE agregarpedidoacliente (@CodPed VARCHAR(10), @NombIg VARCHAR(25)) 
AS
BEGIN
  DECLARE @AUX INT;
  IF EXISTS (SELECT * FROM Cliente WHERE nombre_instagram = @NombIg) 
    BEGIN
    IF EXISTS (SELECT * FROM Pedido WHERE codigo_pedido = @CodPed) 
	   BEGIN
	      IF EXISTS (SELECT * FROM Cliente_Pedido WHERE codigo_pedido = @CodPed AND nombre_instagram = @NombIg) 
		     BEGIN --identifica si ya existe el pedido para el cliente
	            SET @AUX = -1; 
			 END 
	      ELSE
		     BEGIN 
			    INSERT INTO Cliente_Pedido VALUES(@NombIg,@CodPed);
		SET @AUX = 1;
			  END
	   END
	ELSE 
	   BEGIN
	      SET @AUX = -2;
	   END
    END
  ELSE
     BEGIN
        SET @AUX = -3; 
     END
  RETURN @AUX;
END
GO
------------------------------------------------------
IF OBJECT_ID ('agregarproductoapedido','P') IS NOT NULL
   DROP PROCEDURE agregarproductoapedido;
GO
CREATE PROCEDURE agregarproductoapedido (@CodPed VARCHAR(10), @CodProd VARCHAR(10)) 
AS
BEGIN
  DECLARE @AUX INT;
  IF EXISTS (SELECT * FROM Pedido WHERE codigo_pedido = @CodPed) 
    BEGIN
    IF EXISTS (SELECT * FROM Producto WHERE codigo_producto = @CodProd) 
	   BEGIN
	      IF EXISTS (SELECT * FROM Producto_Pedido WHERE codigo_pedido = @CodPed AND codigo_producto = @CodProd) 
		     BEGIN 
	            SET @AUX = -1; 
			 END 
	      ELSE
		     BEGIN 
			    INSERT INTO Producto_Pedido VALUES(@CodProd,@CodPed);
		SET @AUX = 1;
			  END
	   END
	ELSE 
	   BEGIN
	      SET @AUX = -2;
	   END
    END
  ELSE
     BEGIN
        SET @AUX = -3; 
     END
  RETURN @AUX;
END
GO
