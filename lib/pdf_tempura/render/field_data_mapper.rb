module PdfTempura
  module Render
    class FieldDataMapper

      def self.map(fields, data)
        fields.inject({}) { |memo,field|
          memo[field] = data[field.name]
          memo
        }
      end

    end
  end
end
