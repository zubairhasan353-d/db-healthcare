DECLARE @Datetime DATETIME = '01/01/2022 09:00:00', @AddSeconds AS INTEGER = 9678;

DECLARE @InvoiceID AS UNIQUEIDENTIFIER;
DECLARE add_datetime CURSOR FOR
	SELECT 
		InvoiceID
	FROM 
		Billings 
	ORDER BY
		InvoiceID 

	OPEN add_datetime
	
	FETCH NEXT FROM add_datetime INTO @InvoiceID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN 
		SET @Datetime = DATEADD(SECOND, @AddSeconds, @Datetime)
		IF DATEPART(HOUR, @Datetime) >= 18
			SET @Datetime = DATEADD(HOUR, 15, @Datetime)

		IF DATENAME(DW, @Datetime) = 'Saturday'
			SET @Datetime = DATEADD(DAY, 2, @Datetime)
		ELSE IF DATENAME(DW, @Datetime) = 'Sunday'
			SET @Datetime = DATEADD(DAY, 1, @Datetime)

		UPDATE Billings SET Bill_Date = @Datetime WHERE InvoiceID = @InvoiceID
		FETCH NEXT FROM add_datetime INTO @InvoiceID
	END;
CLOSE add_datetime;
DEALLOCATE add_datetime;

SELECT * FROM Billings;