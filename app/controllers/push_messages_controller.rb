class PushMessagesController < ApplicationController
  def create
    client.push
    flash.now[:notice] = 'Push message enqueued'
  rescue => e
    flash.now[:alert] = 'Error enqueueing message'
    logger.error(e)
  end
end
