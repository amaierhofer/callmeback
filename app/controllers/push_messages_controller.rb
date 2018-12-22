class PushMessagesController < ApplicationController
  def create
    client.push
  end
end
