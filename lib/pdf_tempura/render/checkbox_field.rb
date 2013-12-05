module PdfTempura
  module Render
    class CheckboxField < TextField

      def render(pdf)
        pdf.fill_color = "000000"
        pdf.font "Courier", style: :normal
        field_bounds_box(pdf) do
          padding_bounds_box(pdf) do
            if @value
              pdf.text_box "X", valign: :center, align: :center, single_line: true, size: @field.height
            end
          end
        end
        Field::CheckboxAnnotationRenderer.new(@field).render(pdf) if draw_outlines?
      end

    end
  end
end

require_relative 'field/checkbox_annotation_renderer'

