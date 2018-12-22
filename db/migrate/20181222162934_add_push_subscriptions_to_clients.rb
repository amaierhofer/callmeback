class AddPushSubscriptionsToClients < ActiveRecord::Migration[5.2]
  def change
    add_column(:clients, :push_subscription, :json)
    add_column(:clients, :push_count, :integer, default: 0)
    remove_column(:clients, :endpoint, :string)
  end
end
