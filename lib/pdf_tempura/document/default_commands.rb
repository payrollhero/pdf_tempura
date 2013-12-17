module PdfTempura
  module Document::DefaultCommands

    def self.included(base)
      base.send(:attr_accessor, :fields)
    end

    def text_field(name, coordinates, dimensions, options = {})
      fields << Document::TextField.new(name, coordinates, dimensions, @options.merge(options))
    end

    def checkbox_field(name, coordinates, dimensions, options = {})
      fields << Document::CheckboxField.new(name, coordinates, dimensions, @options.merge(options))
    end

    def table(name, coordinates, options = {}, &block)
      fields << Document::Table.new(name, coordinates, @options.merge(options), &block)
    end

    def boxed_characters(name, coordinates, height, options = {}, &block)
      fields << Document::BoxedCharacters.new(name, coordinates, height, @options.merge(options), &block)
    end

    def field_set(name,options = {},&block)
      fields << Document::FieldSet.new(name,@options.merge(options),&block)
    end

    def with_default_options(options = {},&block)
      previous_options = @options
      begin
        @options = @options.merge(options)
        instance_eval(&block)
      ensure
        @options = previous_options
      end
    end

  end
end
