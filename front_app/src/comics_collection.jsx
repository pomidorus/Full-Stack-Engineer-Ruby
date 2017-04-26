import React, { Component } from 'react';
import Comic from "./comic";
import './ComicCollection.css';
import logo from './marvel_logo.png';

class ComicsCollection extends Component {
  state = {
    comics: [],
    page: 1,
    search: ''
  };

  add_comics_to_state = (element, index, array) => {
    this.state.comics.push(element);
  };

  search_comics = (key, term, page) => {
    var url;
    if (key === 13) {
      if (term === '') {
        url = 'https://calm-hollows-82969.herokuapp.com/comics?page=' + page;
        this.request_comics(url);
      }

      if (term !== '') {
        url = 'https://calm-hollows-82969.herokuapp.com/comics/search?q=' + term;
        this.request_comics(url);
      }
    }
  }

  update_search_term = (event) => {
    this.setState({search: event.target.value});
    this.setState({comics: []})
  }


  view_page = (page) => {
    if (page >= 1) {
      var url = 'https://calm-hollows-82969.herokuapp.com/comics?page=' + page;
      this.request_comics(url);
      this.setState({page: page});
    }
  }

  request_comics = (url) => {
    var request = new Request(url, {
      method: 'GET',
      mode: 'cors'
    });

    fetch(request)
      .then(response => response.json())
      .then(json => {
        this.setState({comics: []})
        json.forEach(this.add_comics_to_state);
        this.forceUpdate();
      });
  };

  componentWillMount() {
    var url = 'https://calm-hollows-82969.herokuapp.com/comics?page=1'
    this.request_comics(url);
  }

  render() {
    var comics = this.state.comics.map(function(comic) {
      return (
        <Comic
          title={comic.title}
          key={comic.comic_id}
          comic_id={comic.comic_id}
          thumbnail_url={comic.thumbnail_url}
          issue_number={comic.issue_number}
          year={comic.year}
          page={this.state.page}
          upvoted={comic.upvoted}
        />
      )}, this);

    return(
        <div className="ComicsCollection">
          <div className="Search">
            <div className="Logo">
              <img src={logo} alt="logo"/>
            </div>
            <input onChange={this.update_search_term} onKeyDown={(event) => this.search_comics(event.keyCode, this.state.search, this.state.page)} />
          </div>

          <div className="Comics">
            {comics}
          </div>

          { this.state.search === '' &&
            <div className="Navigation">
              <div className="Previous" onClick={() => this.view_page(this.state.page - 1)}>&larr; PREVIOUS PAGE</div>
              <div className="Next" onClick={() => this.view_page(this.state.page + 1)}>NEXT PAGE &rarr;</div>
            </div>
          }
        </div>
    );
  }
}

export default ComicsCollection;
