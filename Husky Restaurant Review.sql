-- DROP TABLE statements (respecting referential integrity)
DROP TABLE Recommendation;
DROP TABLE Reservation;
DROP TABLE Review;
DROP TABLE FoodCartRestaurant;
DROP TABLE TakeOutRestaurant;
DROP TABLE SitDownRestaurant;
DROP TABLE Restaurant;
DROP TABLE CreditCard;
DROP TABLE Company;
DROP TABLE User;

-- CREATE TABLE statements
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Password VARCHAR(45) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(70) NOT NULL,
    EmailAddress VARCHAR(75) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE Company (
    CompanyName VARCHAR(255) PRIMARY KEY,
    CompanyDescription CLOB NOT NULL
);


CREATE TABLE CreditCard (
    CardNumber VARCHAR(16) PRIMARY KEY,
    UserID INT,
    ExpirationDate DATE NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

CREATE TABLE Restaurant (
    RestaurantID INT PRIMARY KEY,
    CompanyName VARCHAR(255),
    RestaurantName VARCHAR(255) NOT NULL,
    RestaurantDescription CLOB,
    Menu CLOB,
    ListedHours VARCHAR(255),
    ActivityStatus VARCHAR2(10) CHECK (ActivityStatus IN ('Active', 'Closed')),
    StreetAddress VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    FoodType VARCHAR2(20) CHECK (FoodType IN ('African', 'American', 'Asian', 'European', 'Hispanic')),
    FOREIGN KEY (CompanyName) REFERENCES Company(CompanyName)
);

CREATE TABLE SitDownRestaurant (
	RestaurantID INT PRIMARY KEY,
	Capacity INT NOT NULL,
	FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);
CREATE TABLE TakeOutRestaurant (
	RestaurantID INT PRIMARY KEY,
	MaxWaitTime INT NOT NULL,
	FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);
CREATE TABLE FoodCartRestaurant (
    RestaurantID INT PRIMARY KEY,
    Licensed CHAR(1) CHECK (Licensed IN ('Y', 'N')),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);




CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    CreatedTimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    WrittenReview CLOB,
    Rating DECIMAL(2,1) CHECK (Rating >= 0.0 AND Rating <= 5.0),
    UserID INT,
    RestaurantID INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);


CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY,
    UserID INT,
    RestaurantID INT,
    StartTimestamp TIMESTAMP,
    EndTimestamp TIMESTAMP,
    PartySize INT CHECK (PartySize > 0),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);


CREATE TABLE Recommendation (
    RecommendationID INT PRIMARY KEY,
    UserID INT,
    RestaurantID INT,
    RecommendedFlag CHAR(1) CHECK (RecommendedFlag IN ('Y', 'N')),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);



***********INSERTATION OF DATA*************
---DATA INSERTION INTO USERS TABLE
INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (1, 'pass123!', 'Amara', 'Nguyen', 'amara.nguyen@email.com', '555-302-9481');

INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (2, 'sunshine22', 'Leo', 'Martinez', 'leo.martinez@email.com', '555-781-0332');

INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (3, 'grapevines', 'Kiana', 'Chen', 'kiana.chen@email.com', '555-294-6623');

INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (4, 'riverRun88', 'James', 'Oluwole', 'james.oluwole@email.com', '555-649-0058');

INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (5, 'skybird1', 'Sofia', 'Delgado', 'sofia.delgado@email.com', '555-113-4789');

INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (6, 'blinkblink', 'Tristan', 'Park', 'tristan.park@email.com', '555-930-5577');

INSERT INTO Users (UserID, Password, FirstName, LastName, EmailAddress, PhoneNumber)
VALUES (7, 'wavebreaker', 'Hailey', 'Johnson', 'hailey.johnson@email.com', '555-420-3784');
                                            
---DATA INSERTION FOR COMPANY TABLE
INSERT INTO Company (CompanyName, CompanyDescription) VALUES
('TasteMakers Inc', 'An innovative restaurant group known for fusion cuisine and upscale dining.');

INSERT INTO Company (CompanyName, CompanyDescription) VALUES
('UrbanEats Group', 'A growing collective of affordable, city-focused food concepts.');

INSERT INTO Company (CompanyName, CompanyDescription) VALUES
('Foodie Nation', 'Operates multiple brands known for vibrant, global flavors and trendy environments.');

INSERT INTO Company (CompanyName, CompanyDescription) VALUES
('Husky Hospitality', 'Family-owned chain of student-loved spots on and near college campuses.');

INSERT INTO Company (CompanyName, CompanyDescription) VALUES
('Savor and Co.', 'Curators of fine dining experiences with emphasis on seasonal ingredients.');

-----DATA INSERTION FOR CREDITCARD

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330001', 1, TO_DATE('12-31-2026', 'MM-DD-YYYY'));

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330002', 2, TO_DATE('09-30-2025', 'MM-DD-YYYY'));

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330003', 3, TO_DATE('01-15-2027', 'MM-DD-YYYY'));

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330004', 4, TO_DATE('03-01-2026', 'MM-DD-YYYY'));

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330005', 5, TO_DATE('07-22-2025', 'MM-DD-YYYY'));

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330006', 6, TO_DATE('06-30-2027', 'MM-DD-YYYY'));

INSERT INTO CreditCard (CardNumber, UserID, ExpirationDate)
VALUES ('4111222233330007', 7, TO_DATE('11-11-2026', 'MM-DD-YYYY'));

----DATA INSERTION FOR RESTAURANT
INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (1, 'TasteMakers Inc', 'Lotus Bloom', 'Modern Asian fusion with seasonal ingredients.', 'Sushi rolls, kimchi tacos, bao buns', 'Mon–Sat 11am–10pm', 'Active', '23 River St', 'Cambridge', 'MA', '02139', 'Asian');

INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (2, 'UrbanEats Group', 'Wrap and Roll', 'Fast-casual Mediterranean wraps and bowls.', 'Falafel wrap, shawarma plate, hummus bowl', 'Daily 10am–9pm', 'Active', '145 Greenway Blvd', 'Boston', 'MA', '02118', 'European');

INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (3, 'Foodie Nation', 'Spice Theory', 'Global street food inspired by international night markets.', 'Tandoori wings, jerk chicken tacos, poutine', 'Thu–Sun 5pm–12am', 'Active', '88 Market Lane', 'Boston', 'MA', '02215', 'Hispanic');

INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (4, 'Savor and Co.', 'Cedar and Sage', 'Upscale farm-to-table New American fare.', 'Roasted duck, mushroom risotto, beet salad', 'Wed–Sun 5pm–10pm', 'Active', '9 Elm St', 'Somerville', 'MA', '02143', 'American');

INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (5, 'Husky Hospitality', 'Grill and Chill', 'Student-favorite burger joint with late-night hours.', 'Classic burger, fries, milkshake', 'Daily 12pm–2am', 'Active', '420 Main St', 'Boston', 'MA', '02115', 'American');

INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (6, 'UrbanEats Group', 'Tamale Cart', 'Mobile tamale stand located on Northeastern campus.', 'Tamales (chicken, pork, cheese), aguas frescas', 'Mon–Fri 10am–3pm', 'Active', 'North Quad Walkway', 'Boston', 'MA', '02115', 'Hispanic');

INSERT INTO Restaurant (RestaurantID, CompanyName, RestaurantName, RestaurantDescription, Menu, ListedHours, ActivityStatus, StreetAddress, City, State, ZipCode, FoodType)
VALUES (7, 'TasteMakers Inc', 'Saffron Lounge', 'Elegant Indian dining with curated tasting menus.', 'Tasting menu, naan trio, paneer curry', 'Tue–Sat 5pm–11pm', 'Closed', '56 Beacon St', 'Boston', 'MA', '02108', 'Asian');

---DATA INSERTION FOR RESTAURANT TYPES 
INSERT INTO SitDownRestaurant (RestaurantID, Capacity) VALUES (1, 70);
INSERT INTO SitDownRestaurant (RestaurantID, Capacity) VALUES (3, 55);
INSERT INTO SitDownRestaurant (RestaurantID, Capacity) VALUES (4, 40);
INSERT INTO SitDownRestaurant (RestaurantID, Capacity) VALUES (7, 60);

INSERT INTO TakeOutRestaurant (RestaurantID, MaxWaitTime) VALUES (2, 15);  -- Wrap and Roll
INSERT INTO TakeOutRestaurant (RestaurantID, MaxWaitTime) VALUES (5, 10);  -- Grill and Chill
INSERT INTO TakeOutRestaurant (RestaurantID, MaxWaitTime) VALUES (6, 5);   -- Tamale Cart 

INSERT INTO FoodCartRestaurant (RestaurantID, Licensed) VALUES (6, 'Y'); -- Tamale Cart
INSERT INTO FoodCartRestaurant (RestaurantID, Licensed) VALUES (2, 'N'); -- Wrap and Roll (imaginary outdoor kiosk version)
INSERT INTO FoodCartRestaurant (RestaurantID, Licensed) VALUES (5, 'Y'); -- Grill and Chill (pop-up version at festivals)

---DATA INSERTION FOR REVIEWS
INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (1, 'Amazing flavors and great ambiance!', 4.8, 1, 1); -- Lotus Bloom

INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (2, 'Fast service, decent food, great price.', 4.2, 2, 2); -- Wrap and Roll

INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (3, 'Spicy food lovers paradise!', 4.5, 3, 3); -- Spice Theory

INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (4, 'A bit pricey but totally worth it.', 4.7, 4, 4); -- Cedar and Sage

INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (5, 'My favorite late-night spot.', 4.9, 5, 5); -- Grill and Chill

INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (6, 'Super convenient and the tamales SLAP.', 4.6, 6, 6); -- Tamale Cart

INSERT INTO Review (ReviewID, WrittenReview, Rating, UserID, RestaurantID)
VALUES (7, 'Closed but I remember the paneer like it was yesterday.', 4.3, 7, 7); -- Saffron Lounge

---DATA INSERTION FOR RESERVATIONS
INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (1, 1, 1, TO_TIMESTAMP('2025-04-17 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-17 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);

INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (2, 2, 2, TO_TIMESTAMP('2025-04-18 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-18 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (3, 3, 3, TO_TIMESTAMP('2025-04-19 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-19 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);

INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (4, 4, 4, TO_TIMESTAMP('2025-04-20 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-20 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);

INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (5, 5, 5, TO_TIMESTAMP('2025-04-21 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-21 22:30:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (6, 6, 6, TO_TIMESTAMP('2025-04-22 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-22 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2);

INSERT INTO Reservation (ReservationID, UserID, RestaurantID, StartTimestamp, EndTimestamp, PartySize)
VALUES (7, 7, 7, TO_TIMESTAMP('2025-04-23 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2025-04-23 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);

---DATA INSERTION FOR RECCOMMENDATION

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (1, 1, 1, 'Y');  -- Amara recommends Lotus Bloom

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (2, 2, 2, 'Y');  -- Leo recommends Wrap and Roll

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (3, 3, 3, 'N');  -- Kiana doesn’t recommend Spice Theory

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (4, 4, 4, 'Y');  -- James recommends Cedar and Sage

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (5, 5, 5, 'Y');  -- Sofia recommends Grill and Chill

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (6, 6, 6, 'Y');  -- Tristan recommends Tamale Cart

INSERT INTO Recommendation (RecommendationID, UserID, RestaurantID, RecommendedFlag)
VALUES (7, 7, 7, 'N');  -- Hailey does NOT recommend Saffron Lounge 





*******QUERIES******

---QUERY 1: Retrieve all active restaurants, including their names, cities, and food types

SELECT RestaurantName, City, FoodType
FROM Restaurant
WHERE ActivityStatus = 'Active';

----QUERY 2: Join user and restaurant data to display who left which review, for what restaurant, and the associated rating

SELECT U.FirstName || ' ' || U.LastName AS Reviewer,
       R.RestaurantName,
       RV.Rating
FROM Review RV
JOIN Users U ON RV.UserID = U.UserID
JOIN Restaurant R ON RV.RestaurantID = R.RestaurantID;

----QUERY 3: Retrieve all reservations for party sizes greater than two, showing the guest's name, restaurant, and reservation time

SELECT U.FirstName || ' ' || U.LastName AS Guest,
       R.RestaurantName,
       RS.PartySize,
       TO_CHAR(RS.StartTimestamp, 'YYYY-MM-DD HH24:MI') AS ReservationStart
FROM Reservation RS
JOIN Users U ON RS.UserID = U.UserID
JOIN Restaurant R ON RS.RestaurantID = R.RestaurantID
WHERE RS.PartySize > 2;
