import React, { Component } from 'react';
import Comic from "./comic";

class ComicsCollection extends Component {
  state = {
    comics: [],
  };

  add_comics_to_state = (element, index, array) => {
    this.state.comics.push(element);
  };

  request_comics = () => {
    var request = new Request('https://calm-hollows-82969.herokuapp.com/comics', {
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
          <Comic title={comic.title} key={comic.comic_id} thumbnail_url={comic.thumbnail_url}/>
      )}, this);

    return(
        <div className="ComicsCollection">
          {comics}
        </div>
    );
  }
}

export default ComicsCollection;
