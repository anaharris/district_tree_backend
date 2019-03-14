class DropCollections < ActiveRecord::Migration[5.2]
  def change
    drop_table :collections
  end
end
