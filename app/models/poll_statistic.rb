class PollStatistic < ActiveRecord::Base
  belongs_to :polls

  def self.group_and_sum
    group(:candidate_name).sum(:percentage)
  end
end
