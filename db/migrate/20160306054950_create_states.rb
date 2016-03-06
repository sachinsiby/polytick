class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.integer :max_republican_delegates
      t.integer :max_democratic_delegates
    end
  end
end
