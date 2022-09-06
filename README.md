# CRUD Restaurants API

## Available Endpoints
* `GET /v1/restaurants` or with some search keywords `GET /v1/restaurants?name=restaurant`
* `POST /v1/restaurants`, with request body: `{ name: "abc", email: "abc@example.com", phone_number: "+6212345612", address: "xyz abc" }`
* `GET /v1/restaurants/:id`
* `PUT /v1/restaurants/:id`, request body same as `POST`
* `DELETE /v1/restaurants/:id`

## Start Running on Your Local Machine
* Clone this repo
* Run `bundle install`
* Run `rails db:create`
* Run `rails db:migrate`
* Run `rails s`
* Open `http://localhost:3000` in your browser
