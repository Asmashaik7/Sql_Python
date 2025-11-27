
--We want to Calculate Discounted Price on original price

create function CalculateDiscountedPrice
(
	@OriginalPrice Decimal(10,2),
	@DiscountRate Decimal(10,2)
)
returns Decimal(10,2)
AS
Begin 
	return @OriginalPrice-(@originalPrice*@DiscountRate/100);
END;

select dbo.CalculateDiscountedPrice(100,10) AS DiscountedPrice;

-- example2
select TrackID, Name, UnitPrice,dbo.CalculateDiscountedPrice(UnitPrice,10) AS FinalAmount
	from track;