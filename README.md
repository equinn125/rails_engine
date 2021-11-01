# Rails Engine

## Description
Rails engine is a e-commerce Rails based API based off of (Little Esty Shop Data)(https://github.com/equinn125/little-esty-shop). This API allows users to query merchants, merchant items, and has CRUD functionality for all items. This API uses some RESTful principles, and has several business intelligence endpoints that allow users to find revenue for a specific merchant, as well as a count of items sold per merchant.

## Gems Used
-Faker
-Factory Bot
-Simplecov 
-Figaro 
-JSONAPI-serializer 
-shoulda-matchers 
-pry


## API Endpoints
|HTTP |Route| Description|
| ----| ------------------|------------|
| GET | /api/v1/merchants | Get all merchants (default 20 per page)|
| GET | /api/v1/merchants?per_page=number&page=number| Get all merchants using pagination|
| GET | /api/v1/merchants/id| Get one merchant by id|
| GET | /api/v1/merchants/id/items|Get all items for one merchant by id|
| GET | /api/v1/merchants/find_all?name=texts|Get all merchants by name|
| GET | /api/v1/items|Get all items (default 20 per page)|
| GET | /api/v1/items?per_page=number&page=number|Get all items using pagination)|
| GET | /api/v1/items/id|Get one item by id|
| POST | /api/v1/items|Create an item|
| PATCH | /api/v1/items/id|Update an item|
| Delete | /api/v1/items/id|Delete an item|
| GET | /api/v1/items/id/merchant|Get an item's merchant|
| GET | /api/v1/items/find?name=text|Get an item by name|
| GET | /api/v1/items/find?min_price=number|Get an item by minimum price|
| GET | /api/v1/items/find?max_price=number|Get an item by maximum price|
| GET | /api/v1/items/find?min_price=number&max_price=number|Get an item by minimum & maximum price|
| GET | /api/v1/revenue/merchants?quantity=number|Get x amount of merchants by most revenue|
| GET | /api/v1/merchants/most_items?quantity=number|Get x amount of merchants by most items|
| GET | /api/v1/revenue/merchants/id|Get revenue for a merchant by id|
| GET | /api/v1/revenue/items?quantity=number|Get x amount of items by most revenue|

