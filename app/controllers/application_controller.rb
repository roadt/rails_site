class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |e| render_error 500, e}
  end

  private
    def render_error(status, err)
      respond_to do |format|
        format.html { render template: "errors/error_#{status}",  status: status }
        format.all { render nothing: true, status: status }
      end
    end
end
