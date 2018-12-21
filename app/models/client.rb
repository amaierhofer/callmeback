class Client < ApplicationRecord
  has_secure_token :auth_token

  def self.current(auth_token, user_agent)
    find_by(auth_token: auth_token) || Client.create!(user_agent: user_agent).tap do |client|
      yield(client.auth_token)
    end
  end
end
