module LolitaEditableList
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Lolita::Generators::FileHelper
      desc "Copy assets and create migrations."
      def copy_assets
        generate("lolita_editable_list:assets")
      end
    end
  end
end
