/*Interview Scenario

👨‍💼 Manager:

"Asma, I suspect duplicate invoices in our Invoice table."

Invoices

InvoiceID    CustomerID    Amount
----------------------------------
1001         101           500
1002         102           700
1001         101           500
1003         103           900
1002         102           700
*/
SELECT CustomerID, 
InvoiceID, COUNT(*) AS Duplicate_Invoice_Count 
FROM Invoices
 group by InvoiceID 
having count(*)>1