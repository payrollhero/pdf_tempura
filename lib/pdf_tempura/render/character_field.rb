module PdfTempura
  module Render
    class CharacterField < Field

      private

      def set_styling(pdf)
        pdf.fill_color = "000000"
        pdf.font_size @field.font_size
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
          valign: @field.valign.to_sym,
          align: @field.alignment.to_sym,
          single_line: !@field.multi_line?,
          overflow: :shrink_to_fit,
          size: @field.font_size,
          leading: @field.leading
        }
      end

      def render_debug_annotation(pdf)
        Debug::CharacterFieldAnnotation.new(@field).render(pdf)
      end

    end
  end
end

require_relative 'debug/character_field_annotation'