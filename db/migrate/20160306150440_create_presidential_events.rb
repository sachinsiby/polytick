class CreatePresidentialEvents < ActiveRecord::Migration
  def change
    create_table :presidential_events do |t|
      t.string   :name
      t.integer  :state_id
      t.datetime :event_date
      t.string   :party
    end
  end
end
