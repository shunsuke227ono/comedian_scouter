class Company < ActiveRecord::Base
  YOSHIMOTO_ID = 1
  HORIPRO_ID = 2

  has_many :comedians_companies
  has_many :comedians, through: :comedians_companies

  class << self
    def yoshimoto
      find(YOSHIMOTO_ID)
    end
    def horipro
      find(HORIPRO_ID)
    end
  end
end
