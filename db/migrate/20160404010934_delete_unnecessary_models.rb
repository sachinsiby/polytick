class DeleteUnnecessaryModels < ActiveRecord::Migration
  def change
    drop_table :delegate_stats
    drop_table :presidential_events
    drop_table :users
    drop_table :states
  end
end
