module PdfTempura
  module Render
    class Field::AnnotationRenderer

      include FieldBounds

      def initialize(field)
        @field = field
      end

      def render(pdf)
        render_boxes(pdf)
        render_text(pdf)
      end

      protected
      
      def transparency
        0.80
      end

      def render_boxes(pdf)
        pdf.line_width = 0.5

        pdf.transparent transparency do
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
      end
      
      def coordinate_offsets
        return {
          xy: [1,-1],
          label: [1,-1]
        }
      end
      
      def render_xy(pdf)
        off = coordinate_offsets[:xy]
        pdf.text_box "x: #{@field.x} y: #{@field.y} w: #{@field.width} h: #{@field.height}", 
            at: [off[0], @field.height+off[1]], 
            width: @field.width-2, 
            height: @field.height-2, 
            valign: :top,
            single_line: true
      end
      
      def render_label(pdf)
        off = coordinate_offsets[:label]
        pdf.text_box "#{@field.name}", 
            at: [off[0], @field.height+off[1]], 
            width: @field.width-2, 
            height: @field.height-2, 
            valign: :bottom, 
            align: :right,
            single_line: true
      end
      
      def render_text(pdf)
        pdf.font_size = 7
        pdf.fill_color = "000066"
        field_bounds_box(pdf) do
          render_xy(pdf)
          render_label(pdf)
        end
      end
      
    end
  end
end
