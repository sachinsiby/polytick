class AddReportingPercentageToResults < ActiveRecord::Migration
  def change
    add_column :results, :reporting_percentage, :decimal 
  end
end
