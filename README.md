# 🍜 Husky Restaurant Review Database

> **Project Goal:** Design and implement a fully normalized relational database for a restaurant review platform — from concept to live, queryable schema.

---

## Overview

Managing restaurant data, user reviews, reservations, and recommendations at scale requires more than a spreadsheet. This project tackles that problem end-to-end: starting from a real business need, identifying entities and relationships, normalizing the schema to 3NF, and building a working Oracle database with live query execution.

The result is a structured, constraint-enforced database that supports multi-type restaurant categorization, user-generated content, and transactional data — all tied together with referential integrity.

---

## Database Design

### Entities

| Entity | Primary Key | Description |
|---|---|---|
| Users | UserID | Platform accounts with contact info |
| Company | CompanyName | Restaurant ownership groups |
| CreditCard | CardNumber | Payment info linked to users |
| Restaurant | RestaurantID | Core restaurant data with location, hours, and cuisine type |
| SitDownRestaurant | RestaurantID | Subtype — adds seating capacity |
| TakeOutRestaurant | RestaurantID | Subtype — adds max wait time |
| FoodCartRestaurant | RestaurantID | Subtype — adds licensing status |
| Review | ReviewID | User-written ratings (0.0–5.0) per restaurant |
| Reservation | ReservationID | Time-based bookings with party size |
| Recommendation | RecommendationID | Binary Y/N endorsements, separate from reviews |

### Key Design Decisions

- **Supertype/subtype pattern** for restaurant categories — a base `Restaurant` table holds shared attributes, with `SitDownRestaurant`, `TakeOutRestaurant`, and `FoodCartRestaurant` extending it with type-specific fields
- **Cascading deletes** on `CreditCard → Users` ensure orphaned payment records are automatically removed
- **CHECK constraints** enforce data quality on `Rating` (0.0–5.0), `ActivityStatus` ('Active'/'Closed'), `FoodType`, and `RecommendedFlag` ('Y'/'N')
- **Recommendation decoupled from Review** — a deliberate modeling choice reflecting that endorsement and written feedback are distinct user actions

---

## Normalization

Schema was designed and verified to **Third Normal Form (3NF)**:
- All non-key attributes depend only on the primary key (no partial dependencies)
- No transitive dependencies between non-key fields
- Subtype tables eliminate redundant attributes across restaurant categories

See `RelationalSchema_3NF` in the project documentation for the full diagram.

---

## Queries

Three business queries were defined and executed against the populated database:

**Query 1 — Active Restaurant Directory**
Retrieves all active restaurants with name, city, and cuisine type.
```sql
SELECT RestaurantName, City, FoodType
FROM Restaurant
WHERE ActivityStatus = 'Active';
```

**Query 2 — Reviewer Activity Report**
Joins Users, Reviews, and Restaurants to surface who reviewed what and at what rating.
```sql
SELECT U.FirstName || ' ' || U.LastName AS Reviewer,
       R.RestaurantName,
       RV.Rating
FROM Review RV
JOIN Users U ON RV.UserID = U.UserID
JOIN Restaurant R ON RV.RestaurantID = R.RestaurantID;
```

**Query 3 — Large Party Reservations**
Filters reservations with party sizes greater than two, returning guest name, restaurant, and formatted start time.
```sql
SELECT U.FirstName || ' ' || U.LastName AS Guest,
       R.RestaurantName,
       RS.PartySize,
       TO_CHAR(RS.StartTimestamp, 'YYYY-MM-DD HH24:MI') AS ReservationStart
FROM Reservation RS
JOIN Users U ON RS.UserID = U.UserID
JOIN Restaurant R ON RS.RestaurantID = R.RestaurantID
WHERE RS.PartySize > 2;
```

---

## Files

```
📁 huskyrestaurantreview
├── HuskyRestaurantReview.sql   # Full DDL, DML, and queries
├── ProjectDocumentation.pdf    # ER diagram, relational schema, entity summary table
└── README.md
```

---

## Tools

`SQL` `Oracle DB` `ER Diagramming` `Relational Schema Design`

---

## Authors

Amber Ramirez, Group 5 — MISM3403 Database Management, Northeastern University
