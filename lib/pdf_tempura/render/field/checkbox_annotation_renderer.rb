module PdfTempura
  module Render
    class Field::CheckboxAnnotationRenderer < Field::AnnotationRenderer
      protected
      
      def coordinate_offsets
        return {
          :xy => [1,16],
          :label => [1,-9]
        }
      end
      
      def render_xy(pdf)
        off = coordinate_offsets[:xy]
        pdf.text_box "x:#{@field.x} y:#{@field.y}\nw:#{@field.width} h:#{@field.height}", 
            at: [off[0], @field.height+off[1]], 
            width: @field.width*4, 
            height: @field.height-2, 
            valign: :top
      end
      
      def render_label(pdf)
        off = coordinate_offsets[:label]
        pdf.text_box "#{@field.name}", 
            at: [off[0], @field.height+off[1]], 
            width: @field.width*2, 
            height: @field.height-2, 
            valign: :bottom, 
            align: :left,
            single_line: true
      end

    end
  end
end

require_relative "annotation_renderer"