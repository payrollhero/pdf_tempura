module PdfTempura
  module Render
    module Debug
      class FieldSetAnnotation < OutsideAnnotation

        private
        def box_color
          "66CCFF"
        end

        def render_xy(pdf)
          #don't render an xy label for this annotation
        end

        def render_label(pdf)
          pdf.text_box "fieldset: #{@field.name}", label_options
        end
      end
    end
  end
end
