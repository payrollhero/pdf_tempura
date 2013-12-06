module PdfTempura
  module Render
    class Table
      include OptionAccess
      include FieldBounds

      def initialize(table, values, options = {})
        @table = table
        @options = options
        @values = values || []

        unless @values.respond_to?(:each)
          raise ArgumentError.new("Expected value passed to table to be an array but it isn't.")
        end
      end

      def render(pdf)
        @table.fields_for(@values) do |field,value|
          Render::Field.generate(field, value, @options).render(pdf)
        end

        render_annotation(pdf) if draw_outlines?
      end

      private

      def render_annotation(pdf)
        Field::AnnotationRenderer::Table.new(@table).render(pdf)
      end

    end
  end
end
