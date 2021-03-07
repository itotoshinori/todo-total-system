class Udemy_check
  def check
    url = 'https://www.udemy.com/ja'
    # urlにアクセスしてhtmlを取得する
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    div_list = doc.search("div")
    sale_coment = div_list.to_s.index("対象コースが")
    sale_coment2 = div_list.to_s.index("セール")
    if sale_coment.to_i > 0 or sale_coment2.to_i > 0
    #if sale_coment.to_i > 0 
      result = true
    else
      result = false
    end
  end 
end