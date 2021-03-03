class Weatheritem
  def initialize(en)
  weather_items= {
  "clear sky"=>{"ja"=>"快晴", "icon"=>"clearsky.png"},
  "few clouds"=>{"ja"=>"くもり雲少なめ","icon"=>"fewclouds.png"},
  "broken clouds"=>{"ja"=>"くもりがち","icon"=>"brokenclouds.png"},
  "scattered clouds"=>{"ja"=>"くもり雲ふつう","icon"=>"scatteredclouds.png"},
  "overcast clouds"=>{"ja"=>"くもり雲多め","icon"=>"overcastclouds.png"},
  "light intensity shower rain"=>{"ja"=>"小雨のにわか雨","icon"=>"lightintensityshowerrain.png"},
  "shower rain"=>{"ja"=>"にわか雨","icon"=>"showerrain.png"},
  "heavy intensity shower rain"=>{"ja"=>"大雨のにわか雨","icon"=>"rain.png"},
  "light rain"=>{"ja"=>"小雨","icon"=>"lightrain.png"},
  "moderate rain"=>{"ja"=>"雨","icon"=>"rain.png"},
  "heavy intensity rain"=>{"ja"=>"大雨","icon"=>"rain.png':"},
  "very heavy rain"=>{"ja"=>"激しい大雨","icon"=>"rain.png"},
  "rain"=>{"ja"=>"雨","icon"=>"rain.png"},
  "thunderstorm"=>{"ja"=>"雷雨","icon"=>"thunderstorm.png"},
  "light snow"=>{"ja"=>"雪","icon"=>"snow.png"},
   "snow"=>{"ja"=>"雪","icon"=>"snow.png"},
   "mist"=>{"ja"=>"雷雨","icon"=>"mist.png"},
   "tornado"=>{"ja"=>"雷雨","icon"=>"thunderstorm.png"},
    }
    begin
      #@ja = en
      @ja = weather_items[en]["ja"]
      @icon = weather_items[en]["icon"]
    rescue => exception
      @ja = "情報取得失敗"
    end
  end
  def ja_name
    @ja
  end
  def icon
    @icon
  end
end