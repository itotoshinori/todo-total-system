require 'rails_helper'

RSpec.describe InquiryChatwork, type: :model do
  before do
    @blog = create(:blog)
    @comment = Comment.create(name:"john",body:"pass",email:"test@example.com",blog_id:1)
  end 
  describe 'chatワークへの登録' do
    before do
      @inquiry = InquiryChatwork.new
    end
    # it '条件が1で必須項目が入力されていれば、チャットワークに送信される' do
    #   @chatwork = @inquiry.push_chatwork_message(@comment,1)
    #   expect(@chatwork).to eq true
    #   #expect(@chatwork).to eq #<Net::HTTPOK 200 OK readbody=true>
    # end
    # it '条件が2で必須項目が入力されていれば、チャットワークに送信される' do
    #   @chatwork = @inquiry.push_chatwork_message(@comment,2)
    #   expect(@chatwork).to eq true
    #   #expect(@chatwork).to eq #<Net::HTTPOK 200 OK readbody=true>
    # end
    # it '条件が3なら、チャットワークに送信される' do
    #   @chatwork = @inquiry.push_chatwork_message(@comment,3)
    #   expect(@chatwork).to eq true
    # end
    # it '条件が4なら、チャットワークに送信されない' do
    #   @chatwork = @inquiry.push_chatwork_message(@comment,4)
    #   expect(@chatwork).to eq false
    # end
    # it '送信内容がなけらば、チャットワークに送信されない' do
    #   @comment = []
    #   @chatwork = @inquiry.push_chatwork_message(@comment,2)
    #   expect(@chatwork).to eq false
    # end
    # it '条件が3で必須項目がなければ、チャットワークに送信されない' do
    #   @comment = []
    #   @chatwork = @inquiry.push_chatwork_message(@comment,3)
    #   expect(@chatwork).to eq false
    # end
  end
end
