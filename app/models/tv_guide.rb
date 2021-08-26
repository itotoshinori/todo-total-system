class Tv_guide
  def schedule_add(userid)
    target_list = 
    ["大河ドラマ","路線バス","松本清張","豊臣秀吉","平家","歴史探偵","黒澤明","三谷幸喜",
    "ブルボン王朝","サッカー 日本代表 中継","日本代表侍ジャパン","新庄剛志","金村義明","野村芳太郎",
    "ローマ","武田邦彦","十字軍","フランス映画","大航海時代","堀江貴文","奄美大島"] 
    tv_chanel = 
    ["ＮＨＫ総合１・東京(Ch.1)","ＮＨＫＥテレ１・東京(Ch.2)","日テレ(Ch.4)","テレビ朝日(Ch.5)","ＴＢＳ(Ch.6)","テレビ東京(Ch.7)",
    "フジテレビ(Ch.8)","ＴＯＫＹＯ　ＭＸ１(Ch.9)","ＢＳ日テレ(Ch.4)","ＢＳ朝日(Ch.5)","ＢＳ-ＴＢＳ(Ch.6)","ＢＳテレ東(Ch.7)","ＢＳフジ(Ch.8)",
    "BS日本映画専門チャンネル","ムービープラス(Ch.632)"]
    main_titles = []
    tV_program = []
    target_list.each do |target|
      tv_chanel_find = false 
      target_url = URI.encode_www_form(keyword: target)
      #url = "https://www.tvkingdom.jp/schedulesBySearch.action?stationPlatformId=1&condition.#{target_url}"
      url = "https://www.tvkingdom.jp/schedulesBySearch.action?stationPlatformId=0&condition.#{target_url}"
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
          tv_chanel_find = tv_chanel.include?(tv_company)
          db_title = title + tv_company + "keyword:" + target
          todo_count = Todo.where('body like ?',"%#{url}%").count
          if todo_count == 0 and title.include?("[再]") == false and title.include?("(仮)") == false and tv_chanel_find
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