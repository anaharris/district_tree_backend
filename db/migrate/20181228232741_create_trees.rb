class CreateTrees < ActiveRecord::Migration[5.2]
  def change
    create_table :trees do |t|
      t.st_point :xy, geographic: true
      t.string  :address
      t.integer :ward
      t.string  :scientific_name
      t.string  :common_name
      t.string  :disease
      t.string  :pests
      t.string  :condition
      t.string  :fam_name
      t.string  :genus_name
      t.timestamps
    end
  end
end
