require 'standalone_migrations'
require './models'
StandaloneMigrations::Tasks.load_tasks



require 'csv'
namespace :csv do
  desc "import the mysql dump from the xamp virtual box"
  task :import  => :environment do
    csv = CSV.read(File.expand_path('db/backup.csv', File.dirname(__FILE__)), :headers => true)
    csv.each do |row|
      t = TextComponent.new(row.to_hash)
      t.save!
    end
  end
end
