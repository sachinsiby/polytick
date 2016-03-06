class StateSerializer < ActiveModel::Serializer
  attributes :name, :max_republican_delegates, :max_democratic_delegates
  has_many :republican_events, each_serializer: PresidentialEventSerializer
  has_many :democratic_events, each_serializer: PresidentialEventSerializer

  has_many :republican_delegate_stats, each_serializer: DelegateStatSerializer
  has_many :democratic_delegate_stats, each_serializer: DelegateStatSerializer

  def republican_events
    object.presidential_events.for_party("Republican")
  end

  def democratic_events
    object.presidential_events.for_party("Democratic")
  end

  def republican_delegate_stats
    object.delegate_stats.for_party("Republican")
  end

  def democratic_delegate_stats
    object.delegate_stats.for_party("Democratic")
  end

end
