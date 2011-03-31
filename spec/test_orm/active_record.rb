require 'active_record'
require 'logger'
dbconf = YAML::load(File.open(File.expand_path('spec/test_orm/config/active_record.yml')))
ActiveRecord::Base.establish_connection(dbconf)
ActiveRecord::Base.logger = Logger.new(File.open(File.expand_path('spec/test_orm/log/database.log'), 'a'))
ActiveRecord::Migrator.up(File.expand_path('spec/test_orm/db/migrate'))
Dir[File.expand_path("spec/test_orm/active_record/**/*.*")].each do |path|
  require path
end
