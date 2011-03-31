class Post < ActiveRecord::Base
  include Lolita::Configuration

  lolita do
    list do
      editable
    end
  end
end
