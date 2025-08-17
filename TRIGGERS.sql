CREATE TRIGGER update_user_borrow_copy
ON Borrowed_Item
AFTER INSERT
AS
BEGIN
    -- Insert necessary data into the User_Borrow_Copy table
    INSERT INTO User_Borrow_Copy (UserID, Copy_ID, Borrow_Date)
    SELECT inserted.UserID, inserted.Copy_ID, GETDATE()
    FROM inserted;
END;

CREATE TRIGGER remove_item_copy_after_borrow
ON Borrowed_Item
AFTER INSERT
AS
BEGIN
    -- Delete the corresponding entry from Item_Copy where the Copy_ID matches the inserted Copy_ID
    DELETE FROM Item_Copy
    WHERE Copy_ID IN (SELECT inserted.Copy_ID FROM inserted);
END;