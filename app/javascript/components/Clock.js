import React from "react"
import PropTypes from "prop-types"
var today = new Date();
var todayDay = today.getMonth() + 1
var tomonth = today.getMonth() + 1
var todate = today.getDate();
var dayOfWeekStr = ["日", "月", "火", "水", "木", "金", "土"][today.getDay()];

class Clock extends React.Component{
 constructor(props) {
    super(props);
    this.state = {
      date: new Date(),
      thisday:""
    };
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
      date: new Date(),
      tomonth:  todayDay,
      today:todate,
      weekday:dayOfWeekStr
    });
  }

  render() {
    return (
      <div>
        <div>今の時刻: {this.state.tomonth}月{this.state.today}日({this.state.weekday}) {this.state.date.toLocaleTimeString()}</div>
      </div>
    );
  }
}
 
export default Clock