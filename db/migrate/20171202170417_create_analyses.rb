class CreateAnalyses < ActiveRecord::Migration[5.1]
  def change
    create_table :analyses, id: :uuid do |t|
      t.uuid :project_id, index: true
      t.string :commit, null: false, index: true
      t.string :status, null: false, index: true

      t.timestamps null: false

      t.index [:project_id, :commit]

      t.foreign_key :projects, on_delete: :cascade
    end
  end
end
