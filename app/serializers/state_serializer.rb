class StateSerializer < ActiveModel::Serializer
  attributes :name, :max_republican_delegates, :max_democratic_delegates
  has_many :republican_events, each_serializer: PresidentialEventSerializer
  has_many :democratic_events, each_serializer: PresidentialEventSerializer

  def republican_events
    object.presidential_events.for_party("Republican")
  end

  def democratic_events
    object.presidential_events.for_party("Democratic")
  end
end
