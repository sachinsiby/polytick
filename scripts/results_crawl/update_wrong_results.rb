module ResultsCrawl
  class UpdateWrongResults
    def update!
      incomplete_states.each do |state|
        other_result = Result.find_by(state: state)
        Result.create(
          {
            name: other_result.name,
            state: state,
            party: party(other_result.party),
            delegates_allocated: "",
            reporting_percentage: 0,
            date: Date.parse(date_mappings[state])
          }
        )
      end
    end

    def update_iowa!
      # special treatment because politico sucks
      r = Result.find_by(state: "Iowa", party: "Democratic").update(
        delegates_allocated: "52/52",
        reporting_percentage: 100,
        result_statistics: iowa_democratic_results.map{ |attrs| ResultStatistic.new(attrs) }
      )
    end

    def party(opposite_party)
      opposite_party == "Republican" ? "Democratic" : "Republican"
    end

    def incomplete_states
      Result.group(:state).count.select{|k,v| v == 1}.keys
    end

    def date_mappings
      {
        "Colorado" => "2016-03-01",
        "Kentucky" => "2016-05-17",
        "Nebraska" => "2016-05-10",
        "Washington" => "2016-05-24"
      }
    end

    def iowa_democratic_results
      [
        {
          candidate_name: "Hillary Clinton",
          percentage: 49.9,
          num_delegates: 29
        },
        {
          candidate_name: "Bernie Sanders",
          percentage: 49.6,
          num_delegates: 21
        },
        {
          candidate_name: "Others",
          percentage: 0.6,
          num_delegates: 0
        },
        {
          candidate_name: "Others",
          percentage: 0,
          num_delegates: 2
        }
      ]
    end
  end
end
