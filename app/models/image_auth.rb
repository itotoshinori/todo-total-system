class ImageAuth
  def initialize(num)
    @num = num
    array = [
      [1, "l1.jpg"], 
      [4, "l2.jpg"], 
      [7, "l3.gif"]
    ]
    @result = array[num][1]
  end
  def auth_dis
    @result 
  end
end
