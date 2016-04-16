class Poll < ActiveRecord::Base
  has_many :poll_statistics, dependent: :destroy
  validates :party, inclusion: { in: ["Republican", "Democratic"] }

  def self.ascending
    order(:end_date)
  end
end
