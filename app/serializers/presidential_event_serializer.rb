class PresidentialEventSerializer < ActiveModel::Serializer
  root false
  attributes :name, :event_date, :party
end
