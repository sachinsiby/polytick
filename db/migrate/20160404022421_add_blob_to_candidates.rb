class AddBlobToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :blob, :string
  end
end
