class Growth < ActiveRecord::Base
  belongs_to :comedian

  def percent
    # 少数第2位まで
    i = (rate*100).to_s.index('.') + 2
    (rate*100).to_s[0..i]
  end

  def decorate_percent
    if rate.present? && rate != -1
      "#{percent}%"
    elsif rate == -1
      "∞"
    end
  end
end
