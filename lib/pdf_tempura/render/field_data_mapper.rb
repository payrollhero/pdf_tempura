module PdfTempura
  module Render
    class FieldDataMapper

      def self.map(fields, data)
        data ||= {}

        fields.each_with_object({}){ |field, memo|
          memo[field] = data[field.name]
        }
      end

    end
  end
end
