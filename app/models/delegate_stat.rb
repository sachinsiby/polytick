class DelegateStat < ActiveRecord::Base
  belongs_to :state
  belongs_to :candidate

  validates  :party, inclusion: { in: ["Republican", "Democratic"] }

  def self.for_party(party)
    where(party: party)
  end
end
