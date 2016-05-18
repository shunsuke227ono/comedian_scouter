class ComediansCompany < ActiveRecord::Base
  belongs_to :comedian
  belongs_to :company
end
