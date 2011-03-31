module Support
  class << self
    def load_rails_application
      require 'rails'
      require 'lolita/rails/all'
      require File.expand_path("spec/test_orm/rails/config/enviroment")
    end
  end
end