class InquiryChatwork
  require 'net/https'
  require 'uri'
  require 'json'
  #git hubでの編集要
  def push_chatwork_message(message,num,url)
    chatwork_room_id = ''
    chatwork_api_token = ''
    uri = URI.parse("https://api.chatwork.com/v2/rooms/#{chatwork_room_id}/messages")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    if message.present? and num <= 4
      if num == 1
        title = message.blog.title
        messagetext = "[To:3775224]#{message.name}さん(#{message.email})からの「#{title}」のブログにコメントがありました。確認をお願いします。#{url}"
      elsif num == 2
        title = "ログインされました"
        messagetext = "[To:3775224]ユーザー#{message.name}のログインがありました。心当たりがなければ、パスワードを変更して下さい。#{url}"
      elsif num == 3
        title = "ログインに失敗したユーザーがいます"
        messagetext = "[To:3775224]ユーザー#{message.name}のログイン失敗がありました。多発するようでしたらご注意下さい。#{url}"
      elsif num == 4
        title = "Udemyでバーゲン実施"
        messagetext = "[To:3775224]Udemyでバーゲンが実施されているようです。ご確認下さい。#{url}"
      end
      http.start do
        req = Net::HTTP::Post.new(uri.path)
        req['X-ChatWorkToken'] = chatwork_api_token
        req.set_form_data(body: messagetext)
        http.request(req) 
        result = true
      end
    else
      result = false
    end
  end
end
