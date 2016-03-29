class ResultSerializer < ActiveModel::Serializer
  attributes :name, :state, :party, :date, :delegates_allocated
  has_many :result_statistics, serializer: ResultStatisticSerializer
end
