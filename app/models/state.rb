class State < ActiveRecord::Base
  has_many :presidential_events
  has_many :delegate_stats
end
