class Udemy_check
  def check
    url = 'https://nuxt-todo-withtoshi.web.app/todos/'
    # urlにアクセスしてhtmlを取得する
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    div_list = doc.search("div")
    sale_coment = div_list.to_s.index("対象コースが")
    if sale_coment.to_i > 0
      result = true
    else
      result = false
    end
  end 
end