class Poll < ActiveRecord::Base
  has_many :poll_statistics
  validates :party, inclusion: { in: ["Republican", "Democratic"] }

  def self.ascending
    order(:end_date)
  end
end
