require 'active_record'
require 'sqlite3'
require 'logger'
require 'pry'
require 'csv'
require 'ruby_spark'

ActiveRecord::Base.logger = Logger.new('debug.log')
configuration = YAML::load(IO.read('config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])

class  Template < ActiveRecord::Base

end

class  Measurement < ActiveRecord::Base

end


