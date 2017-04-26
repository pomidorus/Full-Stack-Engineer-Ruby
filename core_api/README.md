# Marvel Universe Core API
API application for store, cache, search Marvel API Data

### Production
https://calm-hollows-82969.herokuapp.com

- ruby 2.4.0
- rails 5
- grape
- elasticsearch
- rspec

### Deploy
`git subtree push --prefix core_api heroku master`

migrate database: `heroku run --app calm-hollows-82969 rake db:migrate`

grab_data: `heroku run --app calm-hollows-82969 rake marvel:grab_data`

remove all data from DB: `heroku run --app calm-hollows-82969 rake marvel:remove_data`

update elasticsearch index: `heroku run --app calm-hollows-82969 rake environment elasticsearch:import:model CLASS='Comic' FORCE=y`

clear rails cache: `heroku run --app calm-hollows-82969 rake marvel:clear_cache`

## API Endpoints

- `GET /comics?page=` - get paginated comics data
- `GET /comics/search?q=` - search comics by string (characters)
- `POST /comics/:id/upvote?page=` - upvote comic data. Page param used for updating rails cache

## Data

Marvel API do not have options for sorting comics properly as filtering comics which do not have cover image.
So I deciced to grab Marvel data into app database

It is not big - `35_000` records. Right now in the app DB ~ `5_000` records

For API endpoints I use Rails cache and Serialization. So it works very fast versus native API

## Search

Search implemented with elasticsearch. It will return first 12 records, due to default behaviour of elastic search (for pagination purpose)
Basically, when parsing data I saved all characters info into the Comic model. So there is no need to reuse other Marvel API
endpoints.

## Improvements

Order comics on elastic search index
