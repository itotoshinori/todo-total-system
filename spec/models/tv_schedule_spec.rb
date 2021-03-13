require 'rails_helper'

RSpec.describe Tv_schedule, type: :model do
  before do
    @user = User.create(name:"テストユーザー", email:"test@test.com", placecode:"1853908",password:"password", admin:false) 
    @todo = Todo.create(title:"出演番組", term:"2021-03-10",starttime:"9:00",user_id:@user.id)
  end
  #api使用のためテストは不可能
  describe 'スク―ピングテスト' do
    it 'データの結果をテスト' do
      #一回は取得データを返す
      @tv_schedule = Tv_schedule.new.schedule_add(@user.id)
      expect(@tv_schedule).not_to be_nil
      #二回はデータをnilで返す
      @tv_schedule = Tv_schedule.new.schedule_add(@user.id)
      expect(@tv_schedule).to be_nil
    end
  end
end
