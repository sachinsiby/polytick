class PollSerializer < ActiveModel::Serializer
  attributes :name, :poller, :party, :state_name, :start_date, :end_date
  attributes :poll_statistics

  def poll_statistics
    grouped_candidates = object.poll_statistics.group_and_sum.map do |k, v|
      {
        'candidate_name': k.presence || "Others",
        'percentage': v
      }
    end
    grouped_candidates.select{ |e| relevent_candidates.include?(e[:candidate_name]) }.sort{|a,b| a[:percentage] <=> b[:percentage]}.reverse
  end

  def relevent_candidates
    ["Donald Trump", "John Kasich", "Marco Rubio", "Ted Cruz", "Hillary Clinton", "Bernie Sanders"]
  end
end
