class StateSerializer < ActiveModel::Serializer
  attributes :name,:max_republican_delegates, :max_democratic_delegates
end
