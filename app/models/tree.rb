class Tree < ApplicationRecord
  has_many :users, through: :collection
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  def self.my_import(file)
    trees = []
    puts "starting import process"
    CSV.foreach(file, headers: true).with_index(1) do |row, ln|
      puts "preparing line number #{ln}" if ln % 500 == 0
      trees << Tree.new(row.to_h)
    end
    puts 'importing...'
    Tree.import trees
  end

  scope :within, -> (lon, lat, meter) {
    where(%{
     ST_Distance(xy, 'POINT(%f %f)') < %d
    } % [lon, lat, meter])
  }


end
