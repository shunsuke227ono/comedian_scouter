class CoAppear < ActiveRecord::Base
  # NOTE: Ensure 'comedian_id_1 < comedian_id_2'

  def comedians
    Comedian.find([comedian_id_1, comedian_id_2])
  end

  class << self
    def find_pair(comedian_id_a, comedian_id_b)
      find_by(
        comedian_id_1: comedian_id_1(comedian_id_a, comedian_id_b),
        comedian_id_2: comedian_id_2(comedian_id_a, comedian_id_b)
      )
    end

    def create_pair(comedian_id_a, comedian_id_b)
      create(
        comedian_id_1: comedian_id_1(comedian_id_a, comedian_id_b),
        comedian_id_2: comedian_id_2(comedian_id_a, comedian_id_b),
        count: 1
      )
    end

    def count_pair(comedian_id_a, comedian_id_b)
      if co_appear = find_pair(comedian_id_a, comedian_id_b)
        co_appear.count += 1
        co_appear.save
      else
        create_pair(comedian_id_a, comedian_id_b)
      end
    end

    private

    def comedian_id_1(comedian_id_a, comedian_id_b)
      [comedian_id_a, comedian_id_b].min
    end

    def comedian_id_2(comedian_id_a, comedian_id_b)
      [comedian_id_a, comedian_id_b].max
    end
  end
end
