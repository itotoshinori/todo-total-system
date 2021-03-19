class Tv_guide
  def schedule_add(userid)
    target_list = ["新庄剛志","古田淳也","橋下徹","堀江貴文","織田信長","落合陽一","武田邦彦","平家","源氏","家康","秀吉","元寇","チンギス","ナポレオン","奴隷貿易","香港","ドナルド・トランプ","須田慎一郎","里崎智也","松村邦洋","サッカー日本代表"]
    dis_titles = []
    target_list.each do |target|
      taeget = URI.encode_www_form(keyword: target)
      url = "https://www.tvkingdom.jp/schedulesBySearch.action?stationPlatformId=1&condition.#{taeget}"
      # urlにアクセスしてhtmlを取得する
      html = URI.open(url).read
      doc = Nokogiri::HTML.parse(html) 
      tv_title = doc.css('div.utileList').css('a')
      detail = doc.css('p.utileListProperty')
      detail_array = []
      detail.each do |detailtext|
        detail_array.push(detailtext.text) 
      end
      i = 0
      tv_title.each do |out|
        title = out.text.strip
        if  title.length > 11 
          date =  detail_array[i]
          tv_company = date[50..70].strip 
          anaus_date = Date.parse(date[0..8]).to_s
          db_title = title  + " " + tv_company + "" + target + "　テレビ"
          dis_title =  anaus_date + db_title
          stattime = date[13..17].strip
          finishtime = date[20..28].strip
          todo_count = Todo.where('title like ?',"%#{title}%").where(term:anaus_date).count
          if todo_count == 0
            link = "<a href=https://www.tvkingdom.jp#{out[:href]}>テレビ王国</a>"
            @todo = Todo.new(title:db_title, term:anaus_date, starttime:stattime, finishtime:finishtime, body:link, user_id:userid)
            dis_titles.push(dis_title) if @todo.save
          end
        end
      end 
    end
    if dis_titles
      dis_titles
    else
      dis_titles　= "該当がありません"
    end
  end
end