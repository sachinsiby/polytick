class CreatePollStatistics < ActiveRecord::Migration
  def change
    create_table :poll_statistics do |t|
      t.integer :poll_id
      t.decimal :percentage
      t.string  :candidate_name
    end
  end
end
