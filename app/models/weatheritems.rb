class Weatheritem
  def initialize(en)
  weather_items= {
  "clear sky"=>{"ja"=>"快晴", "icon"=>"01d@2x.png"},
  "few clouds"=>{"ja"=>"晴くもり","icon"=>"02d@2x.png"},
  "broken clouds"=>{"ja"=>"くもり","icon"=>"03d@2x.png"},
  "scattered clouds"=>{"ja"=>"くもり","icon"=>"03d@2x.png"},
  "overcast clouds"=>{"ja"=>"くもり","icon"=>"04d@2x.png"},
  "light intensity shower rain"=>{"ja"=>"小雨","icon"=>"09d@2x.png"},
  "shower rain"=>{"ja"=>"にわか雨","icon"=>"09d@2x.png"},
  "heavy intensity shower rain"=>{"ja"=>"大雨","icon"=>"09d@2x.png"},
  "light rain"=>{"ja"=>"小雨","icon"=>"10d@2x.png"},
  "moderate rain"=>{"ja"=>"雨","icon"=>"10d@2x.png"},
  "heavy intensity rain"=>{"ja"=>"大雨","icon"=>"09d@2x.png"},
  "very heavy rain"=>{"ja"=>"強い大雨","icon"=>"10d@2x.png"},
  "rain"=>{"ja"=>"雨","icon"=>"10d@2x.png"},
  "thunderstorm"=>{"ja"=>"雷雨","icon"=>"11d@2x.png"},
  "light snow"=>{"ja"=>"雪","icon"=>"13d@2x.png"},
   "snow"=>{"ja"=>"雪","icon"=>"13d@2x.png"},
   "mist"=>{"ja"=>"霧","icon"=>"50d@2x.png"},
   "tornado"=>{"ja"=>"雷雨","icon"=>"50d@2x.png"},
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