require 'lolita'
require File.expand_path(File.dirname(__FILE__) + '/lolita-editable-list/configuration/editable_list')
require File.expand_path(File.dirname(__FILE__) + '/lolita-editable-list/configuration/list')

# Acts as Engine, to use views/controllers
if defined?(Rails)
  module LolitaEditableList
    class Engine < Rails::Engine
    end
  end
end

# Monkey patch until Lolita will support Hooks

module ActionView
  # = Action View Rendering
  module Rendering
    def self.included(mod)
      mod.class_eval do
        alias_method_chain :render, :lolita_editable
      end
    end

    def render_with_lolita_editable(options = {}, locals = {}, &block)
      model = lolita_mapping.class_name.constantize
      if model.lolita.list.editable?
        if options[:partial] =~ /^\/components\/lolita\/list\/([a-z_]+)$/
          if %w(body_cell display row).include?($1)
            options[:partial] = "/components/lolita/list/editable/#{$1}"
          end
        end
      end
      render_without_lolita_editable(options, locals, &block)
    end
  end
end
