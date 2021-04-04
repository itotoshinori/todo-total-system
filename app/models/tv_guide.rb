

class Tv_guide
  def schedule_add(userid)
    target_list = ["北の国から ドラマ","歴史探偵","巨人 プロ野球 中継","サッカー 日本代表 中継","青天を衝（つ）け 【作】大森美香","新庄剛志","金村義明","朝まで生テレビ","江本孟紀","中田敦彦","織田信長","重塔","法隆寺","平家","吉永小百合","武田邦彦","豊臣秀吉","池上彰","堀江貴文","西村博之","松村邦洋","役所広司"] 
    main_titles = []
    tV_program = []
    target_list.each do |target|
      target_url = URI.encode_www_form(keyword: target)
      url = "https://www.tvkingdom.jp/schedulesBySearch.action?stationPlatformId=1&condition.#{target_url}"
      # urlにアクセスしてhtmlを取得する
      html = URI.open(url).read
      doc = Nokogiri::HTML.parse(html) 
      tv_title = doc.css('div.utileList').css('a')
      detail = doc.css('p.utileListProperty')
      text_an = []
      doc.css('a').each do |anchor|
        text_an.push([anchor.text,anchor[:href]]) if anchor.to_s.include?("/schedule/")
      end
      if text_an.count > 0
        detail = doc.css('div.utileList')
        detail_array = []
        detail.each do |content_text|
          detail_array.push(content_text) 
        end  
        detail_array.each do |content|
          title = content.css('h2').text
          url = content.css("a")[0][:href]
          detail = content.css("p.utileListProperty")
          date = Date.parse(detail.text[0..6]).to_s
          starttime = detail.text[12..17].strip
          finishtime = detail.text[20..29].strip
          tv_company = detail.text[50..70].strip
          db_title = title + tv_company + "keyword:" + target
          todo_count = Todo.where('body like ?',"%#{url}%").count
          if todo_count == 0 and title.include?("[再]") == false and title.include?("(仮)") == false
            link = "<a href=https://www.tvkingdom.jp#{url}>テレビ王国</a>"
            @todo = Todo.new(title:db_title, term:date, starttime:starttime, finishtime:finishtime, body:link, user_id:userid)
            tV_program.push([date.to_s + " "  + starttime + "〜" + finishtime , title + tv_company +"word:" + target]) if @todo.save
          end 
        end
      end
    end
    tV_program
  end
end