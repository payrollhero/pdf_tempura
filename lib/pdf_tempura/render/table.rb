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
          Render::Field.generate(field,value,@options).render(pdf)
        end
        
        Field::TableAnnotationRenderer.new(@table).render(pdf) if draw_outlines?
      end

    end
  end
end

require_relative 'page/grid_renderer'
require_relative 'field/table_annotation_renderer'