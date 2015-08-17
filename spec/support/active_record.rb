require 'active_record'
require 'pry'
require 'sqlite3'
ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML::load(IO.read('db/config.yml'))
ActiveRecord::Base.establish_connection(configuration['test'])
