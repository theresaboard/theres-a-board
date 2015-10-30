class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.datetime   :start, null: false, index: true
      t.integer    :tutor_id, null: false, index: true
      t.integer    :student_id, index: true

      t.timestamps null: false
    end
  end
end
