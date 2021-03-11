class Tv_schedule
  def schedule_add(userid)
    tokyo_tv_company_name =
    ["テレビ朝日","NHK総合・東京","NHK Eテレ・東京","フジテレビ","TOKYO MX1","日本テレビ","TBS","テレビ東京"]
    talents = [
      ["新庄剛志","0000204772"],["金村義明","0000140552"],["江本孟紀","0000014456"],
      ["堀江貴文","1000033841"],["池澤あやか","1000062953"],["西村博之","1000076695"],["落合陽一","2000009546"],
      ["武田邦彦","1000061975"],["ケント・ギルバート","0000006314"],
      ["八田亜矢子","1000046588"],["杉原杏璃","1000074541"],["豊田真由子","2000054878"],
      #["有吉弘行","0000096561"],#["宅麻伸","0000000471"]2000009546
      ["中田敦彦","1000042081"],["橋下徹","1000003362"],
      ["ムロツヨシ","1000044428"],["おいでやす小田","1000085039"],["ぱるる","1000084644"],
      ["野田クリスタル","1000072202"],
      
    ]
    max = talents.length - 1
    non_name_list = ""
    top_dis = []
    for num in 0..max do 
      name = talents[num][0]
      id = talents[num][1]
      url = "https://thetv.jp/person/#{id}/tv/"
      # urlにアクセスしてhtmlを取得する
      html = URI.open(url).read
      tv_news = []
      doc = Nokogiri::HTML.parse(html)
      tv_non = false
      doc.css('p').each do |p|
        tv_news.push(p.text.strip)
      end
      tv_non = tv_news.index("表示する情報がありません。")
      if tv_non.nil?
        tv_shutuen = []
        tv_shutuen = doc.search("p.listHeading") 
        tv_company = doc.search("span.listDetailOnAir__station")   
        tv_shutuen_datetime = doc.search("span.listDetailOnAir__datetime")
        max2 = tv_shutuen.length - 1
        shutuen = []
        shutuen_datetime = []
        for num2 in 0..max2
          shutuen.push([tv_shutuen[num2].text.strip, tv_company[num2], tv_shutuen_datetime[num2].text.strip])  if tokyo_tv_company_name.index(tv_company[num2].text.strip)
        end 
        #non_name_list.concat(name + " ") if shutuen.length == 0 or tv_non
        if  shutuen.length > 0
          shutuen.each do |tv_shutuen, tv_company, tv_shutuen_datetime|
            tv_date = Date.parse(tv_shutuen_datetime[0,10])
            tv_time = tv_shutuen_datetime[13,6]
            #@todo_count = Todo.where('title like ?',tv_shutuen).where(term:tv_date).count
            todo_count = Todo.where('title like ?',"%#{tv_shutuen}%").where(term:tv_date).count
            #todo_count = tv_shutuen + tv_date.to_s
            if todo_count == 0
              link = "<a href=#{url}>TVガイド</a>"
              tv_shutuen_name = tv_shutuen + " " + name + "出演番組" + " " + tv_company
              @todo = Todo.new(title:tv_shutuen_name, term:tv_date,starttime:tv_time,body:link,user_id:userid)
              @top_dis = top_dis.push([tv_shutuen_name, "(" +tv_date.to_s+ " "  + tv_time.to_s + ")からのテレビデータが追加されました"]) if @todo.save
            end
          end
        end
      end
    end
    @top_dis  
  end
end
