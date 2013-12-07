module PdfTempura
  module Render
    module Debug
      class CharacterFieldAnnotation < Annotation::Base
        
        def render(pdf)
          render_boxes(pdf)
        end

      end
    end
  end
end
