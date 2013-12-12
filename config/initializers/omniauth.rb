Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :google_oauth2, SECRETS['oauth2']['google']['key'],  SECRETS['oauth2']['google']['secret']
  provider :github,  SECRETS['oauth2']['github']['key'], SECRETS['oauth2']['github']['secret']
end
OmniAuth.config.full_host  = lambda {|env|
  "http://radt.dyndns.org:8000"
}
