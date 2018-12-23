class ApplicationController < ActionController::Base
  helper_method :client

  private

  def client
    @client ||= Client.current(cookies.permanent[:auth_token], request.user_agent) do |auth_token|
      cookies.permanent[:auth_token] = auth_token
    end
  end
end
