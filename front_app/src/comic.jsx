import React, { Component } from 'react';

class Comic extends Component {
  render() {
    return(
      <div className="Comic">
        <div className="Overlay">
          
        </div>
        <img src={this.props.thumbnail_url} />
      </div>
    );
  }
}

export default Comic;
