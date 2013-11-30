module PdfTempura
  module Render
    class TextField::AnnotationRenderer

      include FieldBounds

      def initialize(field)
        @field = field
      end

      def render(pdf)

        pdf.line_width = 0.5

        pdf.transparent 0.75 do
          field_bounds_box(pdf) do
            pdf.stroke_color = "CCCC33"
            pdf.stroke_bounds
            pdf.fill_color = "CCCC33"
            pdf.fill { pdf.rectangle [0,pdf.bounds.height], pdf.bounds.width, pdf.bounds.height }

            pdf.transparent 0.25 do
              padding_bounds_box(pdf) do
                pdf.stroke_color = "0000CC"
                pdf.stroke_bounds
              end
            end

          end
        end

        pdf.font_size = 7
        pdf.fill_color = "000066"

        field_bounds_box(pdf) do
          pdf.text_box "x: #{@field.x} y: #{@field.y} w: #{@field.width} h: #{@field.height}", at: [0+1, @field.height-1], width: @field.width-2, height: @field.height-2, valign: :top
          pdf.text_box "#{@field.name}", at: [0+1, @field.height-1], width: @field.width-2, height: @field.height-2, valign: :bottom, align: :right
        end

      end

    end
  end
end
