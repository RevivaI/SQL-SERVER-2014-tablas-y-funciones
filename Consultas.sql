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
			  Pedido.fecha_pago       AS fechadepago
		   FROM 
			  Pedido,
			  Cliente		    
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
END
GO
