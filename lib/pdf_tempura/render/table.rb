module PdfTempura
  module Render
    class Table
      include OptionAccess
      include FieldBounds

      def initialize(table, value, options = {})
        @table = table
        @options = options
        @value = value
      end

      def render(pdf)
        
      end

    end
  end
end

require_relative 'page/grid_renderer'