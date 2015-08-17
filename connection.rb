require 'active_record'
require 'sqlite3'
require 'logger'
require 'pry'
require 'ruby_spark'
require 'twitter'

ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML::load(IO.read('db/config.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])

RubySpark.configuration do |config|
  config.access_token = "e4d91251296c3d1f3d1814865d76868ab73883c3"
  config.timeout      = 10.seconds # defaults to 30 seconds
end

