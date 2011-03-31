module Test
  class Application < Rails::Application
    config.root=File.expand_path("#{File.dirname(__FILE__)}/..")
    config.logger=Logger.new(File.join(config.root,"log","development.log"))
    config.active_support.deprecation=:log
    #config.autoload_paths=File.expand_path("../#{File.dirname(__FILE__)}")
  end
end