class ResultSerializer < ActiveModel::Serializer
  attributes :name, :state, :party, :date, :delegates_allocated, :reporting_percentage
  attributes :result_statistics#, each_serializer: ResultStatisticSerializer

  def result_statistics
    object.result_statistics.group_and_sum.as_json.map{ |i| i.except("id") }.sort_by{|obj| -obj["percentage"] }
  end
end
