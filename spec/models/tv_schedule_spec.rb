require 'rails_helper'

RSpec.describe Tv_schedule, type: :model do
  before do
    @user = User.create(name:"テストユーザー", email:"test@test.com", placecode:"1853908",password:"password", admin:false) 
    @todo = Todo.new(title:"出演番組", term:"2021-03-10",starttime:"9:00",user_id:@user.id)
  end
  #api使用のためテストは不可能
  describe 'スク―ピングテスト' do
    it 'div内にいずれか指定の文字があればtrueを返す' do
         
    
    end
  end
end
