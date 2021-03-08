class Scrap_check
  def check(url,content1,content2,content3)
    #url = 'https://www.udemy.com/ja'
    # urlにアクセスしてhtmlを取得する
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    div_list = doc.search("div")
    coment = div_list.to_s.index(content1)
    coment2 = div_list.to_s.index(content2)
    coment3 = div_list.to_s.index(content3)
    if coment.to_i > 0 or coment2.to_i > 0  or coment3.to_i > 0
      result = true
    else
      result = false
    end
  end 
end