class AddLocationTimeslot < ActiveRecord::Migration
  def change
    add_column :timeslots, :location, :string
  end
end
