class Candidate < ActiveRecord::Base
  validates :party, inclusion: { in: ["Republican", "Democratic"] }
  serialize :policies, JSON
end
