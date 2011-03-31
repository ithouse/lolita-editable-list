module Lolita
  module Configuration
    class EditableList
      lolita_accessor :all_field_names, :except, :only

      def initialize(dbi,*args,&block)
        self.all_field_names = dbi.fields.map{|f| f[:name]}.map(&:to_sym)
        self.set_attributes(*args)
        self.instance_eval(&block) if block_given?
        validate
      end

      def fields
        if self.only
          self.only.select{|name| self.all_field_names.include?(name)}
        else
          if self.except
            self.all_field_names.select{|name| !self.except.include?(name) }
          else
            self.all_field_names
          end
        end
      end

      # Used to set attributes if block not given.
      def set_attributes(*args)
        if args && args[0]
          if args[0].is_a?(Hash)
            args[0].each{|m,value|
              self.send("#{m}=".to_sym,value)
            }
          else
            raise ArgumentError.new("Lolita::Configuration::List::Editable arguments must be Hash instead of #{args[0].class}")
          end
        end
      end

      private

      def validate
        [:except,:only].each do |name|
          unless self.send(name).is_a?(List)
            ArgumentError.new "Lolita::Configuration::List::Editable option :#{name} should be list"
          end if self.send(name)
        end
      end
    end
  end
end