module PdfTempura
  module Render
    class Field
      
      include OptionAccess
      include FieldBounds

      def self.generate(field, value, options)
        case field
        when Document::CheckboxField
          CheckboxField.new(field,value,options)
        when Document::TextField
          TextField.new(field, value, options)
        when Document::Table
          Render::Table.new(field,value,options)
        else
          raise ArgumentError, "don't know how to handle field kind: #{field.class}"
        end
      end

      def initialize(field, value, options = {})
        @field = field
        @value = value
        @options = options
      end

      def render(pdf)
        set_styling(pdf)
        render_field(pdf)
        render_annotation(pdf) if draw_outlines?
      end

    end
  end
end
