class Company < ActiveRecord::Base
  YOSHIMOTO_ID = 1
  HORIPRO_ID = 2
  JINRIKISHA_ID = 3
  WATANABE_ID = 4
  OTAPRO_ID = 5
  MASEKI_ID = 6

  has_many :comedians_companies
  has_many :comedians, through: :comedians_companies

  class << self
    def yoshimoto
      find(YOSHIMOTO_ID)
    end
    def horipro
      find(HORIPRO_ID)
    end
    def jinrikisha
      find(HORIPRO_ID)
    end
    def watanabe
      find(WATANABE_ID)
    end
    def otapro
      find(OTAPRO_ID)
    end
    def maseki
      find(MASEKI_ID)
    end
  end
end
