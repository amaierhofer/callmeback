class SubscriptionsController < ApplicationController
  def create
    subscription = client.subscriptions.build(params.require(:subscription).permit(:url))

    if subscription.save
      flash.now[:notice] = 'Subscription created'
    else
      flash.now[:alert] = subscription.errors.full_messages.first
    end
  end

  def destroy
    client.subscriptions.find_by(id: params[:id]).destroy!
    flash.now[:notice] = 'Subscription destroyed'
  end
end
