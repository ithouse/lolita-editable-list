require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "lolita-editable-list"
  gem.homepage = "http://github.com/ithouse/lolita-list-edit"
  gem.license = "MIT"
  gem.summary = "List inline editing for Lolita"
  gem.description = "With this gem you are able to change content right on the list table, changes will be saved through ajax call."
  gem.email = "gatis@ithouse.lv"
  gem.authors = ["IT House (Latvia)"]
  gem.add_runtime_dependency 'lolita', '~> 3.0.7'
  gem.add_development_dependency 'rspec', '~> 2.5.0'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "lolita-list-edit #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end