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
        y = @table.y
        
        @values.each do |value_hash|
          x = @table.x
          @table.columns.each do |column|
            column.render(pdf,[x,y],value_hash,@options)
            x+= column.width + @table.cell_padding
          end
          
          y-= @table.row_height
        end
        
        Field::TableAnnotationRenderer.new(@table).render(pdf) if draw_outlines?
      end

    end
  end
end

require_relative 'page/grid_renderer'
require_relative 'field/table_annotation_renderer'