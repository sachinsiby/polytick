class AddPartyToPoll < ActiveRecord::Migration
  def change
    add_column :polls, :party, :string
  end
end
