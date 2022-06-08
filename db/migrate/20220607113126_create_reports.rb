class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.integer :risk_level
      t.text :description
      t.datetime :report_date_time
      t.float :latitude
      t.float :longitude
      t.string :address

      t.timestamps
    end
  end
end
