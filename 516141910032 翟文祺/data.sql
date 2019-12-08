INSERT INTO Customer 
VALUES ('Alice', 'F', '19', '12345678', '123456','0','1')

INSERT INTO Customer 
VALUES ('Bob', 'M', '55', '12345679', '1234567','0','1')

INSERT INTO Supplier
VALUES ('CC', 'Charlie','M', '45', '12345689', '12345678')

INSERT INTO Supplier
VALUES ('DD', 'David''M', '21', '23456790', '12345678')

Select CustomerAge,CustomerAccount
From Customer
Where MAX(CustomerAge)>30

Select SupplierSex, SupplierName, SupplierAge
From Supplier
Where SupplierSex='M'

DELETE FROM Supplier
WHERE SupplierName='Charlie'

UPDATE Supplier
SET Supplierage='22'
WHERE name='David';