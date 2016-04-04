class ResultStatistic < ActiveRecord::Base
  def self.group_and_sum
    group(:candidate_name).select("candidate_name, SUM(percentage) AS percentage, SUM(num_delegates) as num_delegates")
  end
end
