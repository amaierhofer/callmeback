class EndpointsController < ApplicationController
  def create
    client.update(endpoint: params[:endpoint])
  end

  def destroy
    client.update(endpoint: nil)
  end
end
