require_relative 'outside_annotation'

module PdfTempura
  module Render
    module Debug
      class CheckboxFieldAnnotation < OutsideAnnotation

        private

        def coordinate_offsets
          {
            xy: [1,16],
            label: [1,-9]
          }
        end

        def label_options
          return super.merge({
              align: :left
            })
        end

      end
    end
  end
end
