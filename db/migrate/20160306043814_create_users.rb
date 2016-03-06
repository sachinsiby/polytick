class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :party, default: 'Independent'
    end

    add_index :users, :email
  end
end
