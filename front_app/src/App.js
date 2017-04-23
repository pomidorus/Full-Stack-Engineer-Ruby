import React, { Component } from 'react';
import ComicsCollection from "./comics_collection";
import './App.css';

class App extends Component {
  render() {
    return (
      <div className="App">
        <ComicsCollection/>
      </div>
    );
  }
}

export default App;
