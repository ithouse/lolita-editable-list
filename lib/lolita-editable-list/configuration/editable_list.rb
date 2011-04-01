module Lolita
  module Configuration
    # ===Example
    #    # all supported columns become editable
    #    lolita do
    #      list do
    #        is_editable
    #      end
    #    end
    #
    #    # only some 
    #    lolita do
    #      list do
    #        is_editable :only => [:name,:title]
    #      end
    #    end
    #
    #    lolita do
    #      list do
    #        is_editable :except => [:name]
    #      end
    #    end
    #
    #    # or as block
    #    lolita do
    #      list do
    #        is_editable do
    #          only :name, :title
    #        end
    #      end
    #    end
    class EditableList
      lolita_accessor :all_column_names, :except, :only
      attr_accessor :list

      SUPPORTED_TYPES = [:integer,:string,:decimal]

      def initialize(list,*args,&block)
        self.list = list
        self.all_column_names = extract_supported_columns list.columns.map(&:name).map(&:to_sym)
        self.set_attributes(*args)
        self.instance_eval(&block) if block_given?
        validate
      end

      def except *args
        @except = args unless args.empty?
        @except
      end

      def only *args
        @only = args unless args.empty?
        @only
      end

      def columns
        if self.only
          self.only.select{|name| self.all_column_names.include?(name)}
        else
          if self.except
            self.all_column_names.select{|name| !self.except.include?(name)}
          else
            self.all_column_names
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

      def extract_supported_columns columns = []
        columns.select do |name|
          # for now we dont support associations
          unless self.list.dbi.reflect_on_association(name)
            field = self.list.dbi.fields.select{|f| f[:name] == name.to_s}.first
            field && SUPPORTED_TYPES.include?(field[:type].to_sym)
          end
        end
      end
    end
  end
end