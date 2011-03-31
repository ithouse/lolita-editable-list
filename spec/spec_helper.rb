require 'rubygems'
require 'cover_me'
require 'factory_girl_rails'
require 'ffaker'
require 'rspec'
require 'rspec-rails'
require 'ruby-debug'

require File.expand_path('spec/test_orm/support')
require File.expand_path(File.dirname(__FILE__) + '/../lib/lolita-editable-list')
LOLITA_ORM = :active_record
require "test_orm/#{LOLITA_ORM}"
Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each {|f| require f}
#Support.load_rails_application

RSpec.configure do |config|
  config.mock_with :rspec
  #config.use_transactional_fixtures = true if LOLITA_ORM == :active_record
end

CoverMe.config do |c|
  c.project.root= File.expand_path('../../',__FILE__)
  c.file_pattern
  c.html_formatter.output_path
end

CoverMe.complete!