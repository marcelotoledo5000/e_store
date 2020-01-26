# README

[![Maintainability][codeclimate-badge-maintainability]][codeclimate-maintainability] [![Test Coverage][codeclimate-badge-coverage]][codeclimate-coverage] [![Build Status][travis-badge]][travis]

## About this project

This project is just a simple API-only to an little bit "E-Commerce".

Is a Rails application to management Products, Orders, Items and Reports.

## Technical Informations and dependencies

```code
- The Ruby language - version 2.7.0
- The Rails gem     - version 6.0
- RSpec             - version 4.0.0.beta4
- Rubocop           - version 0.79.0
- PostgreSQL        - version 10
- Docker            - version 19.03.5-ce
- Docker Compose    - version 1.25.1
```

## To use

Clone the project:

``` Shell
git clone git@github.com:marcelotoledo5000/e_store.git
cd e_store
```

### With Docker (better option)

``` Shell
script/setup    # => development bootstrap, preparing containers
script/server   # => starts server
script/console  # => starts console
script/test     # => running tests
```

#### Running without Docker (not recommended!)

If you prefer, you'll need to update `config/database.yml`:

``` Yaml
# host: db        # when using docker
host: localhost   # when using localhost
```

System dependencies:

* Install and configure the database: [Postgresql-10](https://www.postgresql.org/download/)

And then:

``` Shell
gem install bundler         # => install the last Bundler version
bundle install              # => install the project's gems
rails db:setup db:migrate   # => prepare the database
rails s                     # => starts server
rails c                     # => starts console
bundle exec rspec           # => to running tests
```

### To run app

To see the application in action, starts the rails server to able [http://localhost:3000/](http://localhost:3000.)

### API Documentation

#### Authentication

* No authentication, for now.

#### Domain

[http://localhost:3000/](http://localhost:3000.)

#### Endpoints

##### To Products

INDEX

```code
GET: http://DOMAIN/products
"http://localhost:3000/products"
```

Response:

```code
200 Ok
```

SHOW

```code
GET: http://DOMAIN/products/ID
"http://localhost:3000/products/1"
```

Response:

```code
200 Ok
```

CREATE

```code
POST: http://DOMAIN/products
"http://localhost:3000/products"
Params: Body, JSON(application/json)
```

```json
{
  "name": "KBS Beer",
  "description": "The best of the World!",
  "stock": 400,
  "price": 39.90,
  "custom_attributes": "Custom Aattributes"
}
```

Response:

```code
201 Created
```

UPDATE

```code
PUT: http://DOMAIN/products/ID
"http://localhost:3000/products/1"
Params: Body, JSON(application/json)
```

```json
{
  "name": "KBS - 2016 Edition",
  "description": "The best of the World!",
  "stock": 400,
  "price": 49.90
}
```

Response:

```code
201 Created
```

DESTROY

```code
DELETE: http://DOMAIN/products/ID
"http://localhost:3000/products/2"
```

Response:

```code
204 No Content
```

##### To Customers

INDEX

```code
GET: http://DOMAIN/customers
"http://localhost:3000/customers"
```

Response:

```code
200 Ok
```

SHOW

```code
GET: http://DOMAIN/customers/ID
"http://localhost:3000/customers/1"
```

Response:

```code
200 Ok
```

CREATE

```code
POST: http://DOMAIN/customers
"http://localhost:3000/customers"
Params: Body, JSON(application/json)
```

```json
{
  "name": "Vladimir Harkonnen",
  "cpf": "123.456.789-01",
  "email": "harkonnen@mail.com",
  "birthday": "10/01/1990"
}
```

Response:

```code
201 Created
```

UPDATE

```code
PUT: http://DOMAIN/customers/ID
"http://localhost:3000/customers/1"
Params: Body, JSON(application/json)
```

```json
{
  "email": "mr.harkonnen@mail.com",
  "birthday": "10/01/1980"
}
```

Response:

```code
201 Created
```

##### To Orders

INDEX

```code
GET: http://DOMAIN/orders
"http://localhost:3000/orders"
```

Response:

```code
200 Ok
```

CREATE

```code
POST: http://DOMAIN/customers
"http://localhost:3000/customers"
Params: Body, JSON(application/json)
```

```json
{
  "customer_id":1,
  "freight":22.5,
  "items":[
    {
      "product_id":5,
      "quantity":8
    },
    {
      "product_id":4,
      "quantity":5
    }
  ]
}
```

Response:

```code
201 Created
```

##### To Reports

AVERAGE_TICKET

```code
GET: http://DOMAIN/reports/average_ticket
"http://localhost:3000/reports/average_ticket"
Params: Body, JSON(application/json)
```

```json
{
  "initial_date":"2019-04-18 19:55:15",
  "final_date":"2019-04-25 19:55:15"
}
```

Response:

```code
200 Ok
```

##### PENDING

* Update Orders
* Put JSON API format response
* Show Order with all details
* Separate tests from services and controllers
* Improvement in Average Ticket:
  * verify if period is valid before (initial_date < final_date)
  * verify if have orders into period
* Add process to set new status to orders
* Fix all issues from CodeClimate
* To thinking about possible competition
* Etc

[codeclimate-badge-maintainability]: https://api.codeclimate.com/v1/badges/f6b8e17a017bffe25a5c/maintainability
[codeclimate-maintainability]: https://codeclimate.com/github/marcelotoledo5000/e_store/maintainability

[codeclimate-badge-coverage]: https://api.codeclimate.com/v1/badges/f6b8e17a017bffe25a5c/test_coverage
[codeclimate-coverage]: https://codeclimate.com/github/marcelotoledo5000/e_store/test_coverage

[travis-badge]: https://travis-ci.com/marcelotoledo5000/e_store.svg?branch=master
[travis]: https://travis-ci.com/marcelotoledo5000/e_store
