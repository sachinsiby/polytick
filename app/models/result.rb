class Result < ActiveRecord::Base
  has_many :result_statistics, dependent: :destroy
end
