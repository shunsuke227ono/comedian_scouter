class FuturesController < ApplicationController
  def index
    @growths = Growth.includes(:comedian).where(year: '2015/04/01').
      where('this_year_count < 100 AND last_year_count > 3').order(rate: :desc).limit(50)
  end
end
