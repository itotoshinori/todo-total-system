class ImageAuth
  def initialize(num)
    @num = num
    array = [
      ["4554", "sec0.gif"], 
      ["2209", "sec1.gif"], 
      ["3981", "sec2.gif"],
      ["+LasW#3$2", "l4.gif"],
      ["+95lJKJ?", "l5.gif"],
      ["&YnNa$MkV", "l6.gif"]
    ]
    @result = array[@num][1]
    @result_word = array[@num][0]
  end

  def auth_dis
    @result 
  end

  def auth_dis_word
    @result_word 
  end
end
