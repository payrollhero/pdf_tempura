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
        set_styling(pdf)
        render_field(pdf)
        render_annotation(pdf) if draw_outlines?
      end

      protected

      def set_styling(pdf)
        pdf.fill_color = "000000"
        pdf.font @field.font_name, style: font_style
      end

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

      def render_field(pdf)
        field_bounds_box(pdf) do
          padding_bounds_box(pdf) do
            pdf.text_box(@value.to_s, field_options)
          end
        end
      end

      def field_options
        {
          valign: :center,
          align: @field.alignment.to_sym,
          single_line: !@field.multi_line?,
          overflow: :shrink_to_fit, size: @field.font_size
        }
      end

      def render_annotation(pdf)
        Field::AnnotationRenderer.new(@field).render(pdf)
      end

    end
  end
end

require_relative 'field/annotation_renderer'
