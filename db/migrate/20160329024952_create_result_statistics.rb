class CreateResultStatistics < ActiveRecord::Migration
  def change
    create_table :result_statistics do |t|
      t.integer :result_id
      t.string :candidate_name
      t.decimal :percentage
      t.integer :num_delegates
    end
  end
end
