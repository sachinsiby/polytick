class PollSerializer < ActiveModel::Serializer
  attributes :name, :poller, :state_name, :start_date, :end_date
  has_many :poll_statistics, serializer: PollStatisticSerializer
end
