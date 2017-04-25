import React, { Component } from 'react';
import Comic from "./comic";
import './ComicCollection.css';

class ComicsCollection extends Component {
  state = {
    comics: [],
    page: 1
  };

  add_comics_to_state = (element, index, array) => {
    this.state.comics.push(element);
  };

  previous_page = () => {
    console.log('ok');
  };

  request_comics = () => {
    var request = new Request('https://calm-hollows-82969.herokuapp.com/comics?page=' + this.state.page, {
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
    this.request_comics();
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
          <div className="Comics">
            {comics}
          </div>
          <div className="Navigation">
            <div className="Previous" onClick={this.previous_page}>&larr; PREVIOUS PAGE</div>
            <div className="Next" onClick={this.previous_page}>NEXT PAGE &rarr;</div>
          </div>
        </div>
    );
  }
}

export default ComicsCollection;
