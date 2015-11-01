module EventTrackingHelper
  def intercom_event(event)
    intercom = Intercom::Client.new(app_id: 'orls8tyi', api_key: '2a882cae73c76dd8f623295a0db862c350ac5094')
    intercom.events.create(
      :event_name => event, :created_at => Time.now.to_i,
      :email => current_user.email,
    )
  end
end
