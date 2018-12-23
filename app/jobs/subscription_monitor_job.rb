class SubscriptionMonitorJob < ApplicationJob
  def perform
    each_subscription do |subscription, digest|
      subscription.update(digest: digest)
      next unless subscription.digest_previously_changed?

      subscription.client.push("#{subscription.url} changed")
    end

    reschedule
  end

  def reschedule
    self.class.set(wait: 3.minute).perform_later
  end

  def each_subscription
    Subscription.find_each do |subscription|
      response = subscription.get
      next unless response

      yield subscription, Digest::MD5.hexdigest(response)
    end
  end
end
