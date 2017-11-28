class AddWebhookIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :webhook_id, :integer
  end
end
