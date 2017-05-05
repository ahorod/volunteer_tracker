# Volunteer Tacker webapp
#### HTML webpage, 5.05.2017
#### By Anna Horodetska

## This is a webapp that allows to track volunteers and projects
* Allows to add, view, update and delete projects
* Allows to add, view, update and delete volunteers
* Allows to assign volunteers to projects

## Setup
* If you don't have one install Postgres. Instructions are here https://www.learnhowtoprogram.com/ruby/ruby-database-basics/installing-postgres-7fb0cff7-a0f5-4b61-a0db-8a928b9f67ef
* Open another Terminal window, run $ psql.
* Create volunteer_tracker database - CREATE DATABASE volunteer_tracker;
* Connect to database - \c volunteer_tracker;
* Create tables -
CREATE TABLE projects (id serial PRIMARY KEY, name varchar, info varchar);
CREATE TABLE volunteers (id serial PRIMARY KEY, name varchar);
CREATE TABLE assignments (volunteer_id integer, project_id integer, );
* Clone this repository https://github.com/ahorod/volunteer_tracker
* Run bundle in Terminal window
* Run ruby app.rb in Terminal
* Open on localhost:4567 in browser

## Technologies Used
* HTML
* Ruby
* Postgres SQL

## Support and contact details
Please contact at https://github.com/ahorod

### License
Copyright (c) 2017 **Anna Horodetska**
