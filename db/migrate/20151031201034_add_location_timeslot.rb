class AddLocationTimeslot < ActiveRecord::Migration
  def change
    add_column :timeslots, :onsite, :boolean, :default => true
  end
end
