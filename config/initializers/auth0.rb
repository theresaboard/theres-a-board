Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'IjMvSSE8zdo53tB1QFX5U8EDIxCTzW8Z',
    '_khLXS1jrKQfp8r-wLpBVzfni0NF_BGkfLvFDT3pIimXpBFr7SOTR2zx4iBeeyJz',
    'dbc-mentor-me.auth0.com',
    callback_path: "/auth/auth0/callback"
  )
end