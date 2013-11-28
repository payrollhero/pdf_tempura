module PdfTempura
  module Render
    class Field

      def self.generate(field, value)
        case field.kind
        when :text
          TextField.new(field, value)
        else
          raise ArgumentError, "don't know how to handle field kind: #{field.kind.inspect}"
        end
      end

    end
  end
end
