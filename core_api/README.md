# Marvel Universe Core API

### Deploy
`git subtree push --prefix core_api heroku master`

`heroku run --app calm-hollows-82969 rake db:migrate`

`heroku run --app calm-hollows-82969 rake marvel:grab_data`

`heroku run --app calm-hollows-82969 rake marvel:remove_data`

### Production
https://calm-hollows-82969.herokuapp.com

### Gems

grape

dotenv

[Marvelite](https://rubygems.org/gems/marvelite) - Simple wrapper around the Marvel Comics API. Top gem for the Marvel API: [link](https://www.ruby-toolbox.com/search?utf8=%E2%9C%93&q=marvel) 
