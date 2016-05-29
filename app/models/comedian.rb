class Comedian < ActiveRecord::Base
  has_one :comedians_company
  has_one :company, through: :comedians_company
  has_many :weekly_tweets
  has_many :monthly_appears
  has_many :growths

  scope :appeared, -> { where("appear_count >= 1")}

  def appear
    update(appear_count: appear_count+1)
  end
end
