class Scrap_check
  def check(userid,url,name,content1,content2,content3)
    #url = 'https://www.udemy.com/ja'
    # urlにアクセスしてhtmlを取得する
    @content1 = content1
    @content2 = content2
    @content3 = content3
    today = Date.today
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    div_list = doc.search("div")
    @coment = div_list.to_s.index(content1)
    @coment2 = div_list.to_s.index(content2)
    @coment3 = div_list.to_s.index(content3)
    if coment.to_i > 0 or coment2.to_i > 0  or coment3.to_i > 0
      #バーゲン時はTodoに自動的に購入検討をタスクを新規で入力及びチャットワーク登録でプッシュ通知
      content = "<a href=#{url}>#{name}</a>"
      @todo = Todo.create(title:name,term:today,body:content,user_id:userid)
      user = User.find(userid)
      @chatwork = InquiryChatwork.new
      @chatwork.push_chatwork_message(user, 4, url) 
      result = true  
    else
      result = false
    end
  end
  def check_gyou
    if @coment
      resurlt = @content1 + ":" + @coment.to_s + "行で見つかる"
    else
      result = "#{@content1}は対象なし"
    end
  end
  def check_gyou2
    if @coment2
      resurlt = @content2 + ":" + @coment2.to_s + "行で見つかる"
    else
      result = "#{@content2}は対象なし"
    end
  end
  def check_gyou3
    if @coment3
      resurlt = @content3 + ":" + @coment3.to_s + "行で見つかる"
    else
      result = "#{@content3}は対象なし"
    end
  end
end