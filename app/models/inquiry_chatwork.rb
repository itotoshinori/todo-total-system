class InquiryChatwork
  require 'net/https'
  require 'uri'
  require 'json'
  #git hubでの編集要
  def push_chatwork_message(message,num)
    chatwork_room_id = ''
    chatwork_api_token = ''
    uri = URI.parse("https://api.chatwork.com/v2/rooms/#{chatwork_room_id}/messages")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    if message.present? and num <=2
      if num == 1
        title = message.blog.title
        messagetext = "[To:3]#{message.name}さん(#{message.email})から「#{title}」のブログにコメントがありました。確認をお願いします。"
      elsif num == 2
        title ="ログインされました"
        messagetext = "[To:q]ユーザー#{message.name}にログインがありました。心当たりがなければ、パスワードを変更して下さい。"
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

