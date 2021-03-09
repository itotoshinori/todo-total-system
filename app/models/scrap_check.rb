class Scrap_check
  def check(userid,url,name,content1,content2,content3)
    #url = 'https://www.udemy.com/ja'
    # urlにアクセスしてhtmlを取得する
    today = Date.today
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    div_list = doc.search("div")
    coment = div_list.to_s.index(content1)
    coment2 = div_list.to_s.index(content2)
    coment3 = div_list.to_s.index(content3)
    if coment.to_i > 0 or coment2.to_i > 0  or coment3.to_i > 0
      @check_gyou = content1 + ":" + coment.to_s
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
    if @check_gyou
      resurlt = @check_gyou
    else
      result = "対象なし"
    end
  end
end