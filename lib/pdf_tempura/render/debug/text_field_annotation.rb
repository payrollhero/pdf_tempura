module PdfTempura
  module Render
    module Debug
      class TextFieldAnnotation < Annotation::Base

        private

        def coordinate_offsets
          {
            xy: [1,-1],
            label: [1,-1]
          }
        end

        def field_options
          off = coordinate_offsets[:xy]

          {
            at: [off[0], @field.height + off[1]],
            width: @field.width - 2,
            height: @field.height - 2,
            valign: :top,
            single_line: true
          }
        end

        def label_options
          off = coordinate_offsets[:label]
          {
            at: [off[0], @field.height + off[1]],
            width: @field.width - 2,
            height: @field.height - 2,
            valign: :bottom,
            align: :right,
            single_line: true
          }
        end

      end
    end
  end
end
