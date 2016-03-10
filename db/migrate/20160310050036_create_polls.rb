class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :name
      t.string :poller
      t.string :state_name
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
