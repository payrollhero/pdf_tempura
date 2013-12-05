module PdfTempura
  module Render
    class Field::TableAnnotationRenderer < Field::AnnotationRenderer
      protected
      
      def transparency
        0.25
      end

      def render_text(pdf)
        pdf.font_size = 7
        pdf.fill_color = "000066"

        field_bounds_box(pdf) do
          pdf.text_box "x: #{@field.x} y: #{@field.y} w: #{@field.width} h: #{@field.height}", at: [0+1, @field.height+8], width: @field.width-2, height: @field.height-2, valign: :top
          pdf.text_box "#{@field.name}", at: [0+1, @field.height-9], width: @field.width-2, height: @field.height-2, valign: :bottom, align: :right
        end
      end

    end
  end
end
