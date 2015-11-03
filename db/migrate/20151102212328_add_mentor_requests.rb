class AddMentorRequests < ActiveRecord::Migration
  def change
    create_table :mentor_requests do |t|
      t.belongs_to :student, null: false
      t.boolean :open, default: true

      t.timestamps null: false
    end
  end
end
