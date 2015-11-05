class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.string :url, null: false
      t.string :title, null: false
      t.string :description
      t.string :category
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
