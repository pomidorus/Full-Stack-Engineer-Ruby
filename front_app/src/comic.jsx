import React, { Component } from 'react';
import './Comic.css';

class Comic extends Component {
  state = {
    isUpvoted: false,
  };

  upvote_comic = () => {
    this.setState({isUpvoted: !this.state.isUpvoted});
    console.log('ok');
  };

  render() {
    return(
      <div className={this.state.isUpvoted ? 'Comic Upvoted' : 'Comic'} onClick={this.upvote_comic}>
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
