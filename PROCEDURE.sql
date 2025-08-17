CREATE PROCEDURE GetBorrowedItems
    @UserID CHAR(5),
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN
    SELECT BI.Borrow_ID, IC.Copy_ID, I.Item_Name, I.Publisher, BI.Due_Date, BI.Borrow_Status
    FROM Borrowed_Item BI
    JOIN Item_Copy IC ON BI.Copy_ID = IC.Copy_ID
    JOIN Item I ON IC.Item_ID = I.Item_ID
    WHERE BI.UserID = @UserID
    AND BI.Borrow_ID IN (
        SELECT Borrow_ID
        FROM User_Borrow_Copy
        WHERE Borrow_Date BETWEEN @StartDate AND @EndDate
    );
END;





CREATE PROCEDURE GetOutstandingFines
    @UserID CHAR(5)
AS
BEGIN
    SELECT F.Fine_ID, F.Amount, F.Reason, R.Return_Date
    FROM Fine F
    JOIN Returned R ON F.Return_ID = R.Return_ID
    JOIN Borrowed_Item BI ON R.Borrow_ID = BI.Borrow_ID
    WHERE BI.UserID = @UserID
    AND NOT EXISTS (
        SELECT 1
        FROM Fine F2
        WHERE F2.Fine_ID = F.Fine_ID
        AND F2.Amount = 0  -- Assuming fine is 0 when fully paid
    );
END;

