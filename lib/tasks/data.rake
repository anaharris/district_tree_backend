require 'csv'

namespace :data do

  desc "read CSV, remove trees without X and Y, delete the unnecessary columns, merge X and Y, write it to CSV file"
  task prepare: :environment do

    headers = ['xy', 'address', 'ward', 'scientific_name', 'common_name', 'disease', 'pests', 'condition', 'fam_name', 'genus_name']
    set = [2, 3, 6, 7, 8, 9, 10, 11, 12, 15, 16, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 31, 32, 33, 34, 35]

    CSV.open('data.csv', 'w', write_headers: true, headers: headers) do |csv|
      # 1. read the CSV, remove the headers and remove the trees with no X and Y values
      puts "reading file: Tree_Data.csv"
      data = CSV.read('Tree_Data.csv')
      puts "cleaning the data"
      data.shift
      data = data.reject {|t| t[0] == nil || t[1] == nil }
      # 2. delete the unnecessary columns
      filtered = data.map {|t| t.delete_if.with_index {|_, index| set.include? index }; t }
      # 3. merge x and y, and save it to data.csv
      puts "about to write data to new CSV"
      filtered.each {|t| x = t.shift; y = t.shift; x_y = "POINT (#{x} #{y})"; t.unshift(x_y); csv << t }
    end

  end

end
