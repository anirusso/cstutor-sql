--BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS Dish (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name VARCHAR(255) NOT NULL,
  Category VARCHAR(255) NOT NULL,
  Vegetarian BOOLEAN,
  Price REAL
);

INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Bacon Pancake", "Breakfast", FALSE, 11.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Blueberry Waffle", "Breakfast", TRUE, 11.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Ham Omelette", "Breakfast", FALSE, 12.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Farmer's Breakfast", "Breakfast", FALSE, 13.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Fruit Partfait", "Breakfast", TRUE, 8.99);

INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("BLT", "Lunch", FALSE, 10.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Hamburger", "Lunch", FALSE, 12.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Chipotle Chicken Taco", "Lunch", FALSE, 12.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Pecan Salad", "Lunch", TRUE, 10.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Broccoli Soup", "Lunch", TRUE, 8.99);

INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Lasagna", "Dinner", FALSE, 13.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Pasta Primavera", "Dinner", TRUE, 13.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Steak & Fries", "Dinner", FALSE, 16.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Salmon Dinner", "Dinner", FALSE, 15.99);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Lobster Bisque", "Dinner", FALSE, 15.99);

INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Tiramisu", "Dessert", TRUE, 7.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Cherry Cheesecake", "Dessert", TRUE, 7.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Brownie", "Dessert", TRUE, 5.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Apple Pie", "Dessert", TRUE, 6.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Lemon Cake", "Dessert", TRUE, 6.00);

INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Martini", "Drink", TRUE, 7.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Cocktail", "Drink", TRUE, 7.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Espresso", "Drink", TRUE, 3.50);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Coffee", "Drink", TRUE, 3.00);
INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Soda", "Drink", TRUE, 2.50);



--New additions:
--INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Grilled Veggie Sandwich", "Lunch", TRUE, 9.99);
--INSERT INTO Dish(Name, Category, Vegetarian, Price) VALUES ("Falafel", "Dinner", TRUE, 14.99);

CREATE TABLE IF NOT EXISTS Restaurant (
  Id INTEGER PRIMARY KEY AUTOINCREMENT,
  Name VARCHAR(255) NOT NULL,
  Location VARCHAR(255) NOT NULL,
  BestSellerId INTEGER
);

INSERT INTO Restaurant(Name, Location, BestSellerId) VALUES ("Cosmo Cafe", "123 Street", 24);
INSERT INTO Restaurant(Name, Location, BestSellerId) VALUES ("Cozy Bistro", "987 Road", 16);
INSERT INTO Restaurant(Name, Location, BestSellerId) VALUES ("Iron Steakhouse", "246 Boulevard", 13);
INSERT INTO Restaurant(Name, Location, BestSellerId) VALUES ("Leaf House", "369 Avenue", 9);
INSERT INTO Restaurant(Name, Location) VALUES ("Bar 110", "110 Crescent");


--COMMIT;