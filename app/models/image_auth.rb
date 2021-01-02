class ImageAuth
  def initialize(num)
    @num = num
    array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @result = array[num][num]
  end
  def auth_dis
    @result 
  end
end
