import React from "react"
import PropTypes from "prop-types"

class Clock extends React.Component{
 constructor(props) {
    super(props);
    this.state = {date: new Date()};
  }

  componentDidMount() {
    this.timerID = setInterval(
      () => this.tick(),
      1000
    );
  }

  componentWillUnmount() {
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({
      date: new Date()
    });
  }

  render() {
    return (
      <div>
        <div>現在の時刻 {this.state.date.toLocaleTimeString()}.</div>
      </div>
    );
  }
}
 
export default Clock