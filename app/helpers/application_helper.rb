module ApplicationHelper
  class Datecollection
  attr_accessor :id,:dateweek
    def initialize(id,dateweek)
      @id=id
      @dateweek=dateweek
    end
  end
  
  class Hourcollection
  attr_accessor :hour
    def initialize(hour)
      @hour=hour
    end
  end
  
  class Mincollection
  attr_accessor :min
    def initialize(min)
      @min=min
    end
  end

  def niketa(d)
    if d.present?
      if d.to_i<10
        kekka="0"+d.to_s
      else
        kekka=d.to_s
      end
      kekka
    end
  end  
  def dateweekday(d)
    if d.present?
      nen=d.year.to_s
      if d.month<10
        mon="0"+d.month.to_s
      else
        mon=d.month.to_s
      end
      if d.day<10
        date="0"+d.day.to_s
      else
        date=d.day.to_s
      end
        kekka=nen[2,2]+"/"+mon+"/"+date
    end
        kekka
  end
  def yearmonth(d)
    if d.present?
      nen=d.year.to_s
      if d.month<10
        mon="0"+d.month.to_s
      else
        mon=d.month.to_s
      end
        kekka=nen[2,2]+"-"+mon
    end
        kekka
  end
  def weekdate(d)
    if d.present?
      youbi = %w[日 月 火 水 木 金 土]
      youbi[d.wday]
    end
  end
  def monthdayyoubi(d)
    if d.present?
        kekka=niketa(d.month)+"/"+niketa(d.day).to_s+"("+weekdate(d)+")"
    end
    kekka
  end
  def mojiseigen_count(moji,jisuu)
    mojihairetu = []
    mojihairetu = moji.chars
    moji_count = 0
    count = 0
    mojihairetu.each do |mo|
      if jisuu > count
        if mo.bytesize == 3
          moji_count = moji_count + 1
        else
          moji_count = moji_count + 2
        end
        count = count + 1
      end
    end
    moji_count
  end
  def mojiseigen(moji,jisuu)
    kekka=moji
    if moji.length > jisuu.to_i 
      kekka = moji[0,mojiseigen_count(moji,jisuu)] + ".."
    else
      kekka
    end
  end
  def nengetu(d)
        if d.present?
            nen=d.year.to_s
            if d.month<10
                mon="0"+d.month.to_s
            else
                mon=d.month.to_s
            end
            kekka=nen[2,2]+"年"+mon+"月"
        end
        kekka
  end
  def monthday(d)
    if d.present?
      if d.month<10
        mon="0"+d.month.to_s
      else
        mon=d.month.to_s
      end
      if d.day<10
        date="0"+d.day.to_s
      else
        date=d.day.to_s
      end
        #kekka=mon+"月"+date+"日"
        kekka = date+"日"
    end
    kekka
  end
  def timehyouji(d)
    if d.present?
      kekka=niketa(d.hour.to_s)+":"+niketa(d.min.to_s)        
    end
      kekka
  end
  def timehyouji2(d)
    if d.present?
      kekka=niketa(d.hour.to_s)+"時"+niketa(d.min.to_s)+"分"        
    end
      kekka
  end
  def holiday(d)
    kekka=HolidayJapan.check(Date.new(d.year,d.month,d.day))
    kekka
  end
  def convertday()
    today = Date.today
    if today.day == 1
      convertday = "0000"
    else
      convertday = convert_day(today)
    end  
  end
end

