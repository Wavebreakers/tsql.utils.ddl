SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[getAccountingMonth] (@date DATE)
RETURNS DATETIME
AS
BEGIN
  -- Declare the return variable here
  DECLARE @month AS DATETIME
  -- Get Next Month 1st mapping shift, then get the month of shifted @date.
  SELECT @month = DATEADD(MONTH, DATEDIFF(MONTH, 0, DATEADD(DAY, [shift], @date)), 0)
  FROM (VALUES
    (1, 6),
    (2, 6),
    (3, 6),
    (4, 6),
    (5, 6),
    (6, 4),
    (7, 5)
  ) as weekdays([weekday], [shift])
  WHERE DATEPART(WEEKDAY, DATEADD(MONTH, DATEDIFF(MONTH, 0, @date) + 1, 0)) = [weekday]
  -- Return the result of the function
  RETURN @month
END
GO
