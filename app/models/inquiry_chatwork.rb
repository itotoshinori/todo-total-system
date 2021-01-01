class InquiryChatwork
  require 'net/https'
  require 'uri'
  require 'json'
  #git hubでの編集要
  def push_chatwork_message(message,num)
    chatwork_room_id = '197330662'
    chatwork_api_token = '74bfe242711fcf573a2379c183b250fb'
    uri = URI.parse("https://api.chatwork.com/v2/rooms/#{chatwork_room_id}/messages")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    if message.present? and num <= 3
      if num == 1
        title = message.blog.title
        messagetext = "[To:3775224]#{message.name}さん(#{message.email})から「#{title}」のブログにコメントがありました。確認をお願いします。"
      elsif num == 2
        title = "ログインされました"
        messagetext = "[To:3775224]ユーザー#{message.name}にログインがありました。心当たりがなければ、パスワードを変更して下さい。"
      elsif num == 3
        title = "ログインに失敗したユーザーがいます"
        messagetext = "[To:3775224]ユーザー#{message.name}にログイン失敗がありました。多発するようでしたらご注意下さい。"
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