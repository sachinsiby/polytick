class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :party
      t.string :image_url
      t.text   :policies, default: "[]"
    end
  end
end
