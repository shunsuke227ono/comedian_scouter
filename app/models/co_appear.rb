class CoAppear < ActiveRecord::Base
  # NOTE: Ensure 'comedian_id_1 < comedian_id_2'
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

    private

    def comedian_id_1(comedian_id_a, comedian_id_b)
      [comedian_id_a, comedian_id_b].min
    end

    def comedian_id_2(comedian_id_a, comedian_id_b)
      [comedian_id_a, comedian_id_b].max
    end
  end
end
