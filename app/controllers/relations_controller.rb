class RelationsController < ApplicationController

  def index
  end

  def map_data
    data = {
      "nodes": [],
      "links": []
    }

    Comedian.includes(:company).where("appear_count > 10").each do |c|
      data[:nodes] << {
        "id": c.id,
        "name": c.name,
        "appearcount": c.appear_count,
        "company": c.company.name,
      }
    end

    comedians = Comedian.all.index_by(&:name)

    CoAppear.where("count > 10").each do |c|
      data[:links] << {
        "source": c.comedian_id_1,
        "target": c.comedian_id_2,
        "value": c.count
      }
    end

    render :json => data
  end

  def show
    # NOTE: 特定の芸人に関して調べる
    @comedian = Comedian.find(params[:id])
    @co_appears = CoAppear.all_pairs(@comedian.id).order(count: :desc).limit(10)
  end
end
