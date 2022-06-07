class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true
      t.text :comment
      t.integer :votes

      t.timestamps
    end
  end
end
