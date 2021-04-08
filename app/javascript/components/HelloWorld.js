import React from "react"
import PropTypes from "prop-types"
var today = new Date();
var todayDay = today.getMonth() + 1
var dayOfWeek = today.getDay();
var dayOfWeekStr = ["日", "月", "火", "水", "木", "金", "土"][dayOfWeek];
class HelloWorld extends React.Component
{
  constructor( props )
  {
    super( props );
    this.state = { aisatu: "おはよう!" }
  }
  render()
  {
    let thisday =  todayDay + "月" + today.getDate() + "日" 
    let greeting = this.state.aisatu
    if ( today.getHours() >= 19 || today.getHours() <= 3 ) {
      greeting = "こんばんは!"
    } else if ( today.getHours() >= 10 ) {
      greeting = "こんにちは!"
    }
    return (
      <React.Fragment>
        {greeting}
       本日は{ thisday}({dayOfWeekStr})です
      </React.Fragment>
    );
  }
}
 
export default HelloWorld
