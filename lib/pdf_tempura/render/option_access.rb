module PdfTempura
  module Render
    module OptionAccess

      private

      def debug_options
        @options[:debug].kind_of?(Array) ? @options[:debug] : []
      end

      def draw_grid?
        debug_options.include?(:grid)
      end

      def draw_outlines?
        debug_options.include?(:outlines)
      end

    end
  end
end
