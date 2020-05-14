GO
Create function agregarpedidoacliente (@CodPed Int, @NombIg VARCHAR(25)) RETURNS INT
AS
BEGIN
  IF EXISTS (SELECT * FROM Cliente WHERE nombre_instagram = @NombIg) 
    IF EXISTS (SELECT * FROM Pedido WHERE codigo_pedido = @CodPed) 
	  IF EXISTS (SELECT * FROM Cliente_Pedido WHERE codigo_pedido = @CodPed AND nombre_instagram = @NombIg) --identifica si ya existe el pedido para el cliente
	      return -1;
      ELSE
	      INSERT INTO Cliente_Pedido VALUES(@NombIg,@CodPed);
	return 1;
	  end
	  return -2;	
  end 
  else 
   return -3;
  end
END
GO
