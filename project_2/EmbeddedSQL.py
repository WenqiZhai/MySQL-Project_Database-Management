#EmbeddedSQL for WenqiZHAI's Second Homework
#Imported from Anaconda
import mysql.connector as ms
ms.__version__

mydb= mysql.connector.connect(host='localhost', user='admin',passwd='admin')
mycursor =mydb.cursor()
mycursor.execute('show databases')
for i in mycursor:
    print(i)
#trigger 1
import mysql.connector
mydb.commit()
mycursor.execute(" drop trigger if exists trigger_order")
trigger1 = ( "Delimiter $$ \n"
"create trigger trigger_order\n"
"BEFORE INSERT ON payment_description FOR EACH ROW\n"
"BEGIN \n"
"DECLARE var int;\n"
"DECLARE mesg varchar(20);\n"
"SELECT product_amount INTO var \n"
"FROM product \n"
"where product_id=NEW.product_id;\n"
"IF var<NEW.purchase_amount \n"
   "THEN SELECT XXXX INTO mesg; #禁止在订单表插入记录\n"
"ELSE\n"
   "UPDATE product SET product_amount=product_amount-NEW.purchase_amount\n"
   "where product_id=NEW.product_id;  #更新库存\n"
   "DELETE FROM Shopping_Cart_Description WHERE product_id=NEW.product_id;  #删除购物车\n"
"END IF; \n"
"END $$\n")
mycursor.execute(trigger1)
mydb.commit()
mydb.close()
#trigger 2
import mysql.connector
mydb.commit()
mycursor.execute((" drop trigger if exists trigger_order")
trigger2 =("Delimiter $$  \n"
"create trigger trigger_limitpassword \n"
"before insert on user for each row\n"
"begin\n"
  "if len(NEW.password)>30 and PATINDEX('%[0-9]%', NEW.password) =0 and PATINDEX('%[a-zA-Z]%', NEW.password) =0\n"
  "then signal sqlstate '45000'\n"
  "set message_text = ‘illegal’;\n"
  "end if;\n"
"End $$\n")
try:
  mycursor.execute(trigger2)
except mysql.connector.Error as err:     # Error if raised
  print("Something went wrong: {}".format(err))
mydb.commit()
mydb.close()
