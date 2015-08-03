require 'csv'
require 'pry'

class Schema < ActiveRecord::Migration
  def up
    csv_text = File.read('db/dump.csv')
    csv = CSV.parse(csv_text, :headers => true)
    row = csv.first
    binding.pry
    binding.pry
  end
end
