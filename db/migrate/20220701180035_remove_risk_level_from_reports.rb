class RemoveRiskLevelFromReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :risk_level, :integer
  end
end
