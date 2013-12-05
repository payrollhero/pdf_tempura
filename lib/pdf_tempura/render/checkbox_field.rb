module PdfTempura
  module Render
    class CheckboxField < Field
      protected
      def set_styling(pdf)
        pdf.fill_color = "000000"
        pdf.font "Courier", style: :normal
      end

      def render_field(pdf)
        field_bounds_box(pdf) do
          padding_bounds_box(pdf) do
            if @value
              pdf.text_box "X", valign: :center, align: :center, single_line: true, size: @field.height
            end
          end
        end
      end

      def render_annotation(pdf)
        Field::CheckboxAnnotationRenderer.new(@field).render(pdf)
      end
    
    
    end
  end
end

require_relative 'field/checkbox_annotation_renderer'

