module Lolita
  module Configuration
    class List
      lolita_accessor :editable
      def editable(*args, &block)
        @editable ||= Lolita::Configuration::EditableList.new(@dbi,*args, &block)
      end
    end
  end
end