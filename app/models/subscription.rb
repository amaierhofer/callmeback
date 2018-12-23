class Subscription < ApplicationRecord
  belongs_to :client, counter_cache: true

  before_validation :set_missing_scheme, if: :url

  validate :assert_url
  validates :url, uniqueness: { scope: :client_id }

  scope :list, -> { order(:url) }

  def get
    Net::HTTP.get(URI.parse(url))
  rescue => e
    Rails.logger.error e
    nil
  end

  private

  def set_missing_scheme
    self.url = "https://#{url}" unless url[%r{:/}]
  end

  def assert_url
    errors.add(:base, 'Only http/https urls accepted') unless url =~ %r{^https?://}
  end
end
