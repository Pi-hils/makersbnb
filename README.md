# Airbnb Clone Web App

<img src="https://user-images.githubusercontent.com/55639318/90200485-e51be200-ddcf-11ea-921c-23553ea1f6c3.png">

<br>

## Wireframe

<img src="https://user-images.githubusercontent.com/55639318/90190223-8433e000-ddb6-11ea-99a3-7713e3284443.png">

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
So the guest knows the name of where they may stay,
I should be able to name a space.


As a host,
So guest has some information of where they will be staying,
I should be able to provide a short description of a space.


As a host,
So guest knows the affordability of a space,
I should be able to price a space per night.


As a host,
So guests are aware of availability,
I should be able to offer a range of dates for when a space will be available.


As a host
With multiple spaces available,
I would like to be able to list multiple spaces so they can be booked.


As a guest,
So I can choose a preference,
I would like to be able to view listings.


As a guest,
So I know I have a place to stay,
I would like to be able to hire an available space for one night so it can be approved by the host who owns the space.


As a host,
So I can decide who uses my space,
I would like to get the option to approve requests to hire spaces that I own.


As a host,
So a guest can pay for their stay,
I would like to be able to approve requests to hire.


As a guest,
So I don't run into any conflicts,
I would like to know if a space is unavailable on a given date.


As a guest,
So I have a chance to find a space,
I can still book a space until the host has confirmed a request for hire.

```
