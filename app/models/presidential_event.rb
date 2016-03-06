class PresidentialEvent < ActiveRecord::Base
  belongs_to :state

  validates :party, inclusion: { in: ["Republican", "Democratic"] }

  def self.for_party(party)
    where(party: party)
  end
end
