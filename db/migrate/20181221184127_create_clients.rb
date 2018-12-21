class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :auth_token, null: false, index: true
      t.string :user_agent, null: false
      t.string :endpoint
    end
  end
end
