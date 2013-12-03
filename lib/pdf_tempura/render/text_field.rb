module PdfTempura
  module Render
    class TextField

      include OptionAccess
      include FieldBounds

      def initialize(field, value, options = {})
        @field = field
        @value = value
        @options = options
      end

      def render(pdf)
        pdf.fill_color = "000000"
        pdf.font @field.font_name, style: font_style
        field_bounds_box(pdf) do
          padding_bounds_box(pdf) do
            pdf.text_box @value.to_s, valign: :center, align: @field.alignment.to_sym, single_line: !@field.multi_line?, overflow: :shrink_to_fit, size: @field.font_size
          end
        end
        TextField::AnnotationRenderer.new(@field).render(pdf) if draw_outlines?
      end

      private

      def font_style
        if @field.bold? && @field.italic?
          :bold_italic
        elsif @field.bold?
          :bold
        elsif @field.italic?
          :italic
        else
          :normal
        end
      end

    end
  end
end

require_relative 'text_field/annotation_renderer'
