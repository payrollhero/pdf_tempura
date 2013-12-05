module PdfTempura
  module Render
    class Field::CheckboxAnnotationRenderer < Field::AnnotationRenderer

      private

      def coordinate_offsets
        {
          xy: [1,16],
          label: [1,-9]
        }
      end

      def render_xy(pdf)
        pdf.text_box "x:#{@field.x} y:#{@field.y}\nw:#{@field.width} h:#{@field.height}", field_options
     end

      def render_label(pdf)
        pdf.text_box "#{@field.name}", label_options
      end

      private

      def field_options
        off = coordinate_offsets[:xy]

        {
          at: [off[0], @field.height+off[1]],
          width: @field.width * 4,
          height: @field.height - 2,
          valign: :top
        }
      end

      def label_options
        off = coordinate_offsets[:label]

        {
          at: [off[0], @field.height + off[1]],
          width: @field.width * 2,
          height: @field.height - 2,
          valign: :bottom,
          align: :left,
          single_line: true
        }
      end

    end
  end
end

require_relative "annotation_renderer"
