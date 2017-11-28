class AddSetUpAtToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :set_up_at, :datetime
  end
end
