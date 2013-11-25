
require 'omniauth'

module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      # change the class name and the :name option to match your application name
      option :name, :doorkeeper

      option :client_options, {
        :site => "http://localhost:3002",
      }

      uid { raw_info["id"] }

      info do
        {
          :email => raw_info["email"]
          # and anything else you want to return to your API consumers
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/profile.json').parsed
      end
    end
  end
end
