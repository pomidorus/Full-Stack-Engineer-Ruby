import React, { Component } from 'react';
import Comic from "./comic";
import './ComicCollection.css';
import logo from './marvel_logo.png';

class ComicsCollection extends Component {
  state = {
    comics: [],
    page: 2,
    search: ''
  };

  add_comics_to_state = (element, index, array) => {
    this.state.comics.push(element);
  };

  search_comics = (event) => {
    if ((event.keyCode === 13) &&  (this.state.search == ''))  {
      this.request_comics(1);
    }

    if ((event.keyCode === 13) &&  (this.state.search != ''))  {
      this.search_comics_request(1, this.state.search);
    }
  }

  update_search_term = (event) => {
    this.setState({search: event.target.value});
    this.setState({comics: []})
  }

  previous_page = () => {
    if (this.state.page > 1) {
      this.setState({page: this.state.page - 1});
      this.request_comics(this.state.page);
    }
  };

  next_page = () => {
    this.setState({page: this.state.page + 1});
    this.request_comics(this.state.page);
  };

  search_comics_request = (page, search) => {
    var request = new Request('https://calm-hollows-82969.herokuapp.com/comics?page=' + page +'&search=' + search, {
      method: 'GET',
      mode: 'cors'
    });

    fetch(request)
        .then(response => response.json())
        .then(json => {
          this.setState({comics: []})
          json['comics'].forEach(this.add_comics_to_state);
          this.forceUpdate();
        });
  };

  request_comics = (page) => {
    var request = new Request('https://calm-hollows-82969.herokuapp.com/comics?page=' + page, {
      method: 'GET',
      mode: 'cors'
    });

    fetch(request)
      .then(response => response.json())
      .then(json => {
        this.setState({comics: []})
        json['comics'].forEach(this.add_comics_to_state);
        this.forceUpdate();
      });
  };

  componentWillMount() {
    this.request_comics(1);
  }

  render() {
    var comics = this.state.comics.map(function(comic) {
      return (
        <Comic
          title={comic.title}
          key={comic.comic_id}
          thumbnail_url={comic.thumbnail_url}
          issue_number={comic.issue_number}
          year={comic.year}
        />
      )}, this);

    return(
        <div className="ComicsCollection">
          <div className="Search">
            <div className="Logo">
              <img src={logo} alt="logo"/>
            </div>
            <input onChange={this.update_search_term} onKeyDown={this.search_comics} />
          </div>

          <div className="Comics">
            {comics}
          </div>

          { this.state.search == '' &&
            <div className="Navigation">
              <div className="Previous" onClick={this.previous_page}>&larr; PREVIOUS PAGE</div>
              <div className="Next" onClick={this.next_page}>NEXT PAGE &rarr;</div>
            </div>
          }
        </div>
    );
  }
}

export default ComicsCollection;
