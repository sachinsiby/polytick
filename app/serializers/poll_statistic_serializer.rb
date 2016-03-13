class PollStatisticSerializer < ActiveModel::Serializer
  attributes :percentage, :candidate_name

  def candidate_name
    object.candidate_name.presence || "Other"
  end
end
