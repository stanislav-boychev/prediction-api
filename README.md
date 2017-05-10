## README

## Prerequisites

Install ruby. The used version is 2.4.1

```
ruby -v
ruby 2.4.1p111 (2017-03-22 revision 58053) [x86_64-darwin16]
```

Install bundle gem `gem bundle install`

Run `bundle install`

## How to run

Run the web app `rails server`

## How to request predictions for two teams match outcome

Example: `http://localhost:3000/v1/predictions?team1=Gambit&team2=Immortals`

The V1 API endpoint accepts two teams as input parameters: team1 and team2. The API returns:
  * `200 OK` with JSON object containing the probability of team1 winning over team2
  * `422 Unprocessable Entity ` with errors JSON object if the probability can't be calculated or one or all of the input parameters are invalid

## How to run the tests

 Run `rspec` in the project folder
