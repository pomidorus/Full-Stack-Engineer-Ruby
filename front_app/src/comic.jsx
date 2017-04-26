import React, { Component } from 'react';
import './Comic.css';

class Comic extends Component {
  state = {
    upvoted: this.props.upvoted,
  };

  upvote_comic_request = (page) => {
    var request = new Request('https://calm-hollows-82969.herokuapp.com/comics/' + this.props.comic_id + '/upvote', {
      method: 'POST',
      mode: 'cors',
      body: JSON.stringify({page: page}),
      headers: new Headers({
        'Content-Type': 'application/json'
      })
    });

    fetch(request)
      .then(response => response.json())
      .then(json => {
        this.setState({upvoted: json['upvoted']});
        this.forceUpdate();
      });
  };

  render() {
    return(
      <div className={this.state.upvoted ? 'Comic Upvoted' : 'Comic'} onClick={() => this.upvote_comic_request(this.props.page)}>
        <div className="Thumbnail">
          <img src={this.props.thumbnail_url} alt={this.props.title}/>
        </div>
        <div className="Overlay">
          <div className="Cover" />
          <div className="Description">
            <div className="Title">
              {this.props.title.toUpperCase()}
            </div>
            <div className="Numbers">
              <div className="IssueNumber">
                {'#' + this.props.issue_number}
              </div>
              <div className="Year">
                {this.props.year}
              </div>
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Comic;
