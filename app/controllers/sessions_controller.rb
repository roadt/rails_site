class SessionsController < Devise::SessionsController
  
  def create_from_auth
#    raise Exception.new(auth_hash.to_yaml+ warden.to_s)

    if auth_hash 
      request.env["devise.mapping"] = Devise.mappings[:user]
      provider = auth_hash[:provider]

      if not Rails.env.production? and provider == "developer"
        create_from_developer(auth_hash) 
      elsif provider == "github"
        create_from_general(auth_hash)
      elsif provider == 'google_oauth2'
        create_from_general(auth_hash)
        #raise Exception.new(auth_hash.to_yaml)
      else
        raise StandardError.new("unknow provider #{provider}")
      end

      redirect_to root_url
    else
      super
    end
  end

  def create_from_general(auth)
    info = auth[:info]
    email = info[:email]
    @user = User.find_or_create_by_email(:email => email)
    scope = Devise::Mapping.find_scope!(@user)
    sign_out(current_user)
    sign_in(@user)
#    warden.set_user(@user)
  end

  def create_from_developer(auth)
    info = auth[:info]
    email = info[:email]
    @user = User.find_or_create_by_email(:email => email)
    scope = Devise::Mapping.find_scope!(@user)
    sign_out(current_user)
    sign_in(@user)
#    warden.set_user(@user)
  end

  def auth_hash
    @auth_hash ||= request.env['omniauth.auth']
  end
end
