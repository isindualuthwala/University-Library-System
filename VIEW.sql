CREATE VIEW Item_Category
AS
SELECT i.Item_Name, c.Category_Name
FROM Item i, Category c, Item_Belongs_Category b
WHERE i.Item_ID = b.Item_ID and b.Category_ID = c.Category_ID

CREATE VIEW Book_Shelf
AS
SELECT i.Item_Name, l.Branch_Name, c.Shelf
FROM Item i, Library_Branch l, Item_Copy c, Library_Has_Copy h
WHERE i.Item_ID = c.Item_ID and c.Copy_ID = h.Copy_ID and h.Branch_ID = l.Branch_ID