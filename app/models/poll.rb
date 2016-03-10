class Poll < ActiveRecord::Base
  has_many :poll_statistics
end
