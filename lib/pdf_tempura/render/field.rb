module PdfTempura
  module Render
    module Field

      def self.generate(field, value, options)
        case field
        when Document::TextField
          TextField.new(field, value, options)
        when Document::Table
          Render::Table.new(field,value,options)
        else
          raise ArgumentError, "don't know how to handle field kind: #{field.class}"
        end
      end

    end
  end
end
