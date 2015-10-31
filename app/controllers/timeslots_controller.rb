class TimeslotsController < ApplicationController
  def show
    @timeslot = Timeslot.find(params[:id])
    render '/timeslots/show'
  end
end
