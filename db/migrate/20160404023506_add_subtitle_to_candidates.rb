class AddSubtitleToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :subtitle, :string
  end
end
