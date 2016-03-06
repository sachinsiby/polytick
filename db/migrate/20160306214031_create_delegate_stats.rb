class CreateDelegateStats < ActiveRecord::Migration
  def change
    create_table :delegate_stats do |t|
      t.integer :state_id
      t.integer :candidate_id
      t.string  :party
      t.integer :count
    end
  end
end
