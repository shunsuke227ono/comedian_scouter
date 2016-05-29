class ComediansController < ApplicationController
  def index
    @comedians = Comedian.all
  end

  def show
    @comedian = Comedian.find(params[:id])
    @rank = Comedian.where("appear_count > ?", @comedian.appear_count).count + 1
    @whole_n = Comedian.count

    number = params[:number] || 10
    @co_appears = CoAppear.all_pairs(@comedian.id).order(count: :desc).limit(number)
  end
end
