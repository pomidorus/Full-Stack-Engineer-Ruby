import React, { Component } from 'react';
import './Comic.css';

class Comic extends Component {
  render() {
    return(
      <div className="Comic">
        <div className="Thumbnail">
          <img src={this.props.thumbnail_url} alt={this.props.title}/>
        </div>
        <div className="Overlay">
          <div className="Cover" />
          <div className="Description">
            <div className="Title">
              {this.props.title}
            </div>
          </div>
        </div>
      </div>
    );
  }
}

export default Comic;
