class Config
  require "open-uri"
  require "nokogiri"
  def initialize
    
  end

  def prezero_exclusion(num)
    num_int = num.to_i
    if num_int < 10
      num = num_int.to_s
    else 
      num
    end
  end
  
end