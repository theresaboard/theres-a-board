class CreateAvailableMentors < ActiveRecord::Migration
  def change
    create_table :available_mentors do |t|
      t.integer :mentor_id, index: true

      t.timestamps null: false
    end
  end
end
