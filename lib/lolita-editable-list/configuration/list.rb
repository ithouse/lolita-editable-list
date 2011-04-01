module Lolita
  module Configuration
    class List
      lolita_accessor :editable
      def is_editable(*args, &block)
        @editable ||= Lolita::Configuration::EditableList.new(self,*args, &block)
      end

      def editable?
        self.editable
      end
    end
  end
end