delimiter $$
create procedure buyout(In X int)
Begin
    Declare total_amount INT;
    Select product_amount into total_amount
    From product
    Where unit_price<100;
	  IF total_amount IS NULL 
        THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An error occurred';
	  IF (total_amount-X)<0
		THEN SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An error occurred';
	  ELSE
		  UPDATE product 
		  SET total_amount = total_amount  - X
		  where unit_price<100; 
END $$

delimiter $$
create procedure avgpmt(in Y DATETIME)
Begin
  select
  avg(payment_description.tprice=payment_description.purchase_amount*product.unit_price)
  from payment_description,product
  where payment_description.product.id=product.product.id and
  payment_time>=‘Y’ and 
  payment_time< now();
END $$

