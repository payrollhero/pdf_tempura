module PdfTempura
  module Render
    class CheckboxField < Field

      private

      def set_styling(pdf)
        pdf.fill_color = "000000"
        pdf.font "Courier", style: :normal
      end

      def render_field(pdf)
        field_bounds_box(pdf) do
          padding_bounds_box(pdf) do
            pdf.text_box("X", field_options) if @value
          end
        end
      end

      def field_options
        {
          valign: :center,
          align: :center,
          single_line: true,
          size: @field.height
        }
      end

      def render_annotation(pdf)
        Field::AnnotationRenderer::CheckboxField.new(@field).render(pdf)
      end

    end
  end
end
