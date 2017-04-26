# Marvel Universe Core API
API application for store, cache, search Marvel API Data

### Production
https://calm-hollows-82969.herokuapp.com

### Deploy
`git subtree push --prefix core_api heroku master`

migrate database: `heroku run --app calm-hollows-82969 rake db:migrate`

grab_data: `heroku run --app calm-hollows-82969 rake marvel:grab_data`

remove all data from DB: `heroku run --app calm-hollows-82969 rake marvel:remove_data`

update elasticsearch index: `heroku run --app calm-hollows-82969 rake environment elasticsearch:import:model CLASS='Comic' FORCE=y`

clear rails cache: `heroku run --app calm-hollows-82969 rake marvel:clear_cache`

## Data

Marvel API do not have options for sorting comics properly as filtering comics wich do not have cover image.
So I deciced to grab Marvel data into app database

It is not big - `35_000` records. Right now in the app DB ~ `9_000` records

For API endpoints I use Rails cache. So it works very fast regarding native API
