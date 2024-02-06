# README
This README would normally document whatever steps are necessary to get the
application up and running.
Things you may want to cover:

* Setup
	- git clone: https://github.com/Tas-depal/Fitness-Program-Rails-Framework-.git
	- Run the following command:
		- cd Fitness-Program-Rails-Framework

* Requirements
	- Ruby version
		- Check ruby version ie., 3.2.2, If not then install it
	- Docker and docker compose must be installed
	- Postgres must be installed
	- Redis must be installed

 * Run the following commands
 	- gem install bundler
 	- bundle install
 	- docker compose up --build OR docker compose up

* Database creation
 	- Run migrantion
 		- docker compose up run web rails db:migrate

* Configurations
	- Make .env file in root directory and add the following variables and set your own credentials.
		- GOOGLE_CLIENT_ID=xxxxxxxxxxxxxxx
		- GOOGLE_CLIENT_SECRET=xxxxxxxxxxxxxxx
		- STRIPE_PUBLISHABLE_KEY=xxxxxxxxxxxxxxx
		- STRIPE_SECRET_KEY=xxxxxxxxxxxxxxx
	- In development.rb file add the following credentials:
		- TWILIO_ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'.freeze
		- TWILIO_AUTH_TOKEN = 'Your Auth token'.freeze
