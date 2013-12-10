module PdfTempura
  module Render
    module Debug
      class TableAnnotation < OutsideAnnotation

        private
        def box_color
          "66CCFF"
        end

        def transparency
          0.20
        end
      end
    end
  end
end
