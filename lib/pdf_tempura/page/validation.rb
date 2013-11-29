module PdfTempura
  class Page
    module Validation

      private

      def validate_arguments
        raise ArgumentError, "Page number must be a number." unless number.is_a?(Numeric)
      end

    end
  end
end
