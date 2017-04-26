# Marvel frontend application
View, search & upvote your favorite comics

### Production
https://frozen-inlet-64283.herokuapp.com

### Deploy
`git subtree push --prefix front_app heroku_react master`

## Application

Basically app use two components: comic collection & comic. Comic collection send comic and search request
to the api_app. And handle page state. 
Comic component send request for upvoting to api_app and store state of voting status.

Main page
![main page](screen_1.png)
