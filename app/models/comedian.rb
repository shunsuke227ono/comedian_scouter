class Comedian < ActiveRecord::Base
  has_one :comedians_company
  has_one :company, through: :comedians_company
end
