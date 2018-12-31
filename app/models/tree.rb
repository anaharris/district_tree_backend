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

  # for finding trees X distance from
  # a particular point (i.e. radius)
  scope :within, -> (lon, lat, meter) {
    where(%{
     ST_Distance(xy, 'POINT(%f %f)') < %d
    } % [lon, lat, meter])
  }

  # for finding trees within a certain
  # bounding box
  scope :bbox, -> (sw_lon, sw_lat, ne_lon, ne_lat) {
    factory = RGeo::Geographic.spherical_factory(srid: 4326, geo_type: 'point')
    sw = factory.point(sw_lon, sw_lat)
    nw = factory.point(sw_lon, ne_lat)
    ne = factory.point(ne_lon, ne_lat)
    se = factory.point(ne_lon, sw_lat)

    ring = factory.linear_ring([sw, nw, ne, se])
    bbox = factory.polygon(ring)
    where('ST_Intersects(xy, :bbox)', bbox: bbox)
  }

  scope :excellent_condition, -> {
    where(condition: 'Excellent')
  }

end
