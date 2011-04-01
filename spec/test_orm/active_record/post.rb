class Post < ActiveRecord::Base
  include Lolita::Configuration

  lolita do
    list do
      is_editable
    end
  end
end
