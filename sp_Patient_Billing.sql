USE [db-healthcare]
GO
/****** Object:  StoredProcedure [dbo].[Patient_Billing]    Script Date: 2/18/2025 8:24:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Zubair Hasan >
-- Create date: <06 June 2022>
-- Description:	<>
-- =============================================
CREATE PROCEDURE [dbo].[Patient_Billing]
	(@Patient_Id VARCHAR(10) = '%', @Patient_Name VARCHAR(20) = '%')
	-- Add the parameters for the stored procedure here
AS
BEGIN
	SELECT 
		p.PatientID,
		CAST(p.firstname AS VARCHAR(20)) + ' ' + CAST(p.lastname AS VARCHAR(20)) AS [NAME],
		b.Items,
		b.Amount,
		b.Bill_Date [DATE]
	FROM
		Patients p
	INNER JOIN
		Billings b ON p.PatientID = b.PatientID
	WHERE
		p.PatientID LIKE @Patient_Id
		AND 
		(
			p.firstname LIKE @Patient_Name 
			OR
			p.lastname LIKE @Patient_Name
		)
END
GO
