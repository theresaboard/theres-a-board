class AddSubjectBooking < ActiveRecord::Migration
  def change
    add_column :timeslots, :subject, :string
  end
end
