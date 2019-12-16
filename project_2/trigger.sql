Delimiter $$
create trigger trigger_order
BEFORE INSERT ON payment_description FOR EACH ROW
BEGIN
DECLARE var int;
DECLARE mesg varchar(20);
SELECT product_amount INTO var 
FROM product 
where product_id=NEW.product_id;

IF var<NEW.purchase_amount 
   THEN SELECT XXXX INTO mesg; #禁止在订单表插入记录

ELSE 
   UPDATE product SET product_amount=product_amount-NEW.purchase_amount
   where product_id=NEW.product_id;  #更新库存
   DELETE FROM Shopping_Cart_Description WHERE product_id=NEW.product_id;  #删除购物车

END IF; 
END $$

Delimiter $$
create trigger trigger_limitpassword
before insert on user for each row
begin
  if len(NEW.password)>30 and PATINDEX('%[0-9]%', NEW.password) =0 and PATINDEX('%[a-zA-Z]%', NEW.password) =0
  then signal sqlstate '45000' set MYSQL_ERRNO=30001,
   message_text = ‘illegal’;
  end if;
End $$
