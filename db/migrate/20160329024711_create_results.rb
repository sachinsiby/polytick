class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :name, null: false
      t.string :party, null: false
      t.string :state, null: false
      t.datetime :date, null: false
      t.string :delegates_allocated
    end
  end
end
