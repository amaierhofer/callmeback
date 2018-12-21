class ApplicationController < ActionController::Base
  helper_method :client

  private

  def client
    @client ||= Client.current(cookies[:auth_token], request.user_agent) do |auth_token|
      cookies[:auth_token] = auth_token
    end
  end
end
