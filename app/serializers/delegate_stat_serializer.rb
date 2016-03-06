class DelegateStatSerializer < ActiveModel::Serializer
  attributes :candidate, :count

  def candidate
    object.candidate.name
  end
end
