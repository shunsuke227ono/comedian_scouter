class RelationsController < ApplicationController

  def index
  end

  def map_data
    data = {
      "nodes": [],
      "links": []
    }

    Comedian.includes(:company).where("appear_count > 5").each do |c|
      data[:nodes] << {
        "id": c.id,
        "name": c.name,
        "appearcount": c.appear_count,
        "company": c.company.name,
      }
    end

    comedians = Comedian.all.index_by(&:name)

    CoAppear.where("count > 5").each do |c|
      data[:links] << {
        "source": c.comedian_id_1,
        "target": c.comedian_id_2,
        "value": c.count
      }
    end

    render :json => data
  end
end
