## Database Schema

<img src="https://i.gyazo.com/8aa4b97f6f4e2bed05b0318e499bfcb7.png">

## Steps to create database
<ol>
<li>Create database "makersbnb_test" <code>CREATE DATABASE "makersbnb_test"</code><br></li>
<li>Create database "makersbnb_production" <code>CREATE DATABASE "makersbnb_production"</code></li>
<li>Connect to your desired database using <code>\c [database name]</code></li>
<li>Run the queries in */db/migrations/create_tables.sql</li>
</ol>

## MVP
1. A user can add a listing and view
2. Provide relevant attributes of the listing, ie name, description of space, and price per night.

## User Stories
```
As a host,
So I can add listing,
I would like to sign up so I can add a new space.


As a host,
So I can display my available spaces,
I would like to list a new space so it can be booked.


As a host,
So the customer knows the name of where they may stay,
I should be able to name a space.


As a host,
So customer has some information of where they will be staying,
I should be able to provide a short description of a space.


As a host,
So customer knows the affordability of a space,
I should be able to price a space per night.


As a host,
So customers are aware of availability,
I should be able to offer a range of dates where a space is available.


As a host
With multiple spaces available,
I would like to be able to list multiple spaces so they can be booked.


As a customer,
So I can choose a preference,
I would like to be able to view listings.


As a customer,
So I know I have a place to stay,
I would like to be able to hire an available space for one night so it can be approved by the host owning the space.


As a host,
So a customer can pay for their stay,
I would like to be able to approve requests to hire spaces that I own.


As a customer,
So I don't run into any issues,
I cannot book a space if unavailable on a given date.


As a customer,
So I have a chance to find a space, 
I can still book a space until the host has confirmed a request for hire.

```
