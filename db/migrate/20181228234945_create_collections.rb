class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.integer :tree_id
      t.integer :user_id
      t.timestamps
    end
  end
end
