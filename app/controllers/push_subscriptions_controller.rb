class PushSubscriptionsController < ApplicationController
  def create
    client.update(push_subscription: params[:push_subscription])
  end

  def destroy
    client.update(push_subscription: nil)
  end
end
