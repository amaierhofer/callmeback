class AddSubscriptions < ActiveRecord::Migration[5.2]
  def change
    change_table(:clients) do |t|
      t.integer :subscriptions_count, default: 0
    end

    create_table(:subscriptions) do |t|
      t.belongs_to :client, index: true, null: false

      t.string :url, null: false
      t.string :digest

      t.datetime :updated_at
    end
  end
end
