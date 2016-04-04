class CandidateSerializer < ActiveModel::Serializer
  attributes :name, :subtitle, :blob, :policies 
end
