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
| GET | /api/v1/items|Get all items (default 20 per page|



