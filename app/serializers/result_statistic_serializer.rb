class ResultStatisticSerializer < ActiveModel::Serializer
  attributes :candidate_name, :percentage, :num_delegates
end
