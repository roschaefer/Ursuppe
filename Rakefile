require 'standalone_migrations'
StandaloneMigrations::Tasks.load_tasks



require './ursuppe/models'
require 'csv'
namespace :csv do
  desc "import the mysql dump from the xamp virtual box"
  task :import  => :environment do
    csv = CSV.read(File.expand_path('db/backup.csv', File.dirname(__FILE__)), :headers => true)
    csv.each do |row|
      t = Ursuppe::TextComponent.new(row.to_hash)
      t.save!
    end
  end
end
