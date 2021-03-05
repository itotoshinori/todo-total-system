class Weatheritem
  def initialize(en)
  weather_items= {
  "clear sky"=>{"ja"=>"快晴", "icon"=>"01"},
  "few clouds"=>{"ja"=>"晴くもり","icon"=>"02"},
  "broken clouds"=>{"ja"=>"くもり","icon"=>"03"},
  "scattered clouds"=>{"ja"=>"くもり","icon"=>"03"},
  "overcast clouds"=>{"ja"=>"くもり","icon"=>"04"},
  "light intensity shower rain"=>{"ja"=>"小雨","icon"=>"09"},
  "shower rain"=>{"ja"=>"にわか雨","icon"=>"09"},
  "heavy intensity shower rain"=>{"ja"=>"大雨","icon"=>"09"},
  "light rain"=>{"ja"=>"小雨","icon"=>"10"},
  "moderate rain"=>{"ja"=>"雨","icon"=>"10"},
  "heavy intensity rain"=>{"ja"=>"大雨","icon"=>"09"},
  "very heavy rain"=>{"ja"=>"強い大雨","icon"=>"10"},
  "rain"=>{"ja"=>"雨","icon"=>"10"},
  "thunderstorm"=>{"ja"=>"雷雨","icon"=>"11"},
  "light snow"=>{"ja"=>"雪","icon"=>"13"},
   "snow"=>{"ja"=>"雪","icon"=>"13"},
   "mist"=>{"ja"=>"霧","icon"=>"50"},
   "tornado"=>{"ja"=>"雷雨","icon"=>"50"},
    }
    begin
      #@ja = en
      @ja = weather_items[en]["ja"]
      @icon = weather_items[en]["icon"]
    rescue => exception
      @ja = "情報取得失敗"
      @icon = "情報取得失敗"
    end
  end
  def ja_name
    @ja
  end
  def icon
    @icon
  end
end