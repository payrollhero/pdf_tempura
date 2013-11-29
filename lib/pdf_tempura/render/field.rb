module PdfTempura
  module Render
    class Field

      def self.generate(field, value)
        case field.type
        when "text"
          TextField.new(field, value)
        else
          raise ArgumentError, "don't know how to handle field kind: #{field.type.inspect}"
        end
      end

    end
  end
end
