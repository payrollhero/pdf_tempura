module PdfTempura
  module Document::DefaultCommands

    def self.included(base)
      base.send(:attr_accessor, :fields)
    end

    def text_field(name, coordinates, dimensions, options = {})
      fields << Document::TextField.new(name, coordinates, dimensions, default_options.merge(options))
    end

    def checkbox_field(name, coordinates, dimensions, options = {})
      fields << Document::CheckboxField.new(name, coordinates, dimensions, default_options.merge(options))
    end

    def table(name, coordinates, options = {}, &block)
      fields << Document::Table.new(name, coordinates, default_options.merge(options), &block)
    end

    def boxed_characters(name, coordinates, height, options = {}, &block)
      fields << Document::BoxedCharacters.new(name, coordinates, height, default_options.merge(options), &block)
    end

    def field_set(name,&block)
      fields << Document::FieldSet.new(name,default_options,&block)
    end

    def with_default_options(options = {},&block)
      previous_options = @default_options
      begin
        set_default_options(options)
        instance_eval(&block)
      ensure
        set_default_options(previous_options)
      end
    end

    def set_default_options(options)
      @default_options = options
    end

    private
    def default_options
      (@default_options || {}).merge(:default_options => @default_options)
    end

  end
end
