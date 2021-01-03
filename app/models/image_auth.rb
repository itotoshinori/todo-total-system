class ImageAuth
  def initialize(num)
    @num = num
    array = [
      ["4I3hw@65!", "l1.jpg"], 
      ["3kR23*$2", "l2.jpg"], 
      ["5*+75RtY&", "l3.gif"]
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
