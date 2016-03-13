class Poll < ActiveRecord::Base
  has_many :poll_statistics
  validates :party, inclusion: { in: ["Republican", "Democratic"] }
end
