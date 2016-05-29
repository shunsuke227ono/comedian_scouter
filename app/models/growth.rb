class Growth < ActiveRecord::Base
  def percent
    # 少数第2位まで
    i = (rate*100).to_s.index('.') + 2
    (rate*100).to_s[0..i]
  end
end
