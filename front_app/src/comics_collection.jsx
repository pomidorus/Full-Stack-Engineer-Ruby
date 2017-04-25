import React, { Component } from 'react';
import Comic from "./comic";
import './ComicCollection.css';
import logo from './marvel_logo.png';

class ComicsCollection extends Component {
  state = {
    comics: [],
    page: 2
  };

  add_comics_to_state = (element, index, array) => {
    this.state.comics.push(element);
  };

  previous_page = () => {
    if (this.state.page > 1) {
      this.setState({page: this.state.page - 1});
      this.setState({comics: []})
      this.request_comics(this.state.page);
    }
  };

  next_page = () => {
    this.setState({page: this.state.page + 1});
    this.setState({comics: []})
    this.request_comics(this.state.page);
  };

  request_comics = (page) => {
    var request = new Request('https://calm-hollows-82969.herokuapp.com/comics?page=' + page, {
      method: 'GET',
      mode: 'cors'
    });

    fetch(request)
      .then(response => response.json())
      .then(json => {
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
              <img src={logo}/>
            </div>
            <input />
          </div>
          <div className="Comics">
            {comics}
          </div>
          <div className="Navigation">
            <div className="Previous" onClick={this.previous_page}>&larr; PREVIOUS PAGE</div>
            <div className="Next" onClick={this.next_page}>NEXT PAGE &rarr;</div>
          </div>
        </div>
    );
  }
}

export default ComicsCollection;
