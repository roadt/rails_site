Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :google_oauth2, SECRETS['oauth2']['google']['key'],  SECRETS['oauth2']['google']['secret']
  provider :github,  SECRETS['oauth2']['github']['key'], SECRETS['oauth2']['github']['secret']
end
OmniAuth.config.full_host  = lambda {|env|
  real_base_uri = 'HTTP_X_REAL_BASE'
  if env.key?(real_base_uri)  # if proxy send back real base uri
    env[real_base_uri]
  else
    # no proxy, extract from request url
    Rack::Request.new(env).base_url
  end
}
