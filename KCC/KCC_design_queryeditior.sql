SELECT Customers.CustomerName
FROM     Customers INNER JOIN
                  Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName
HAVING (Orders.OrderDate >= CONVERT(DATETIME, '2022-02-18 00: 0:00', 102))