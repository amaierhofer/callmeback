class Client < ApplicationRecord
  has_secure_token :auth_token

  has_many :subscriptions, dependent: :destroy

  def self.current(auth_token, user_agent)
    find_by(auth_token: auth_token) || Client.create!(user_agent: user_agent).tap do |client|
      yield(client.auth_token)
    end
  end

  def push(message = 'Test message')
    Webpush.payload_send(
      message: message,
      endpoint: push_subscription['endpoint'],
      p256dh: push_subscription['keys']['p256dh'],
      auth: push_subscription['keys']['auth'],
      vapid: {
        subject: "mailto:sender@example.com",
        public_key: Rails.application.credentials.vapid_public_key,
        private_key: Rails.application.credentials.vapid_private_key
      },
    )
  end
end
