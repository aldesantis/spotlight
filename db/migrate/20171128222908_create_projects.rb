class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name, null: false
      t.string :repo_provider, null: false
      t.string :repo_uri, null: false
      t.string :encrypted_oauth_access_token, null: false
      t.string :encrypted_oauth_access_token_iv, null: false

      t.timestamps null: false

      t.index :name
      t.index [:repo_provider, :repo_uri]
    end
  end
end
