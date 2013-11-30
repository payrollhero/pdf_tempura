module PdfTempura
  module Render
    module FieldBounds

      private

      def field_bounds_box(pdf)
        pdf.bounding_box([@field.x, @field.y], width: @field.width, height: @field.height) do
          yield
        end
      end

      def padding_bounds_box(pdf)
        x = @field.padding[3]
        y = pdf.bounds.height - @field.padding[0]
        width = pdf.bounds.width - @field.padding[1] - @field.padding[3]
        height = pdf.bounds.height - @field.padding[0] - @field.padding[2]
        pdf.bounding_box([x,y], width: width, height: height) do
          yield
        end
      end

    end
  end
end
