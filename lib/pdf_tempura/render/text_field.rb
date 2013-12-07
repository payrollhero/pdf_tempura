module PdfTempura
  module Render
    class TextField < CharacterField

      private

      def render_debug_annotation(pdf)
        Debug::TextFieldAnnotation.new(@field).render(pdf)
      end

    end
  end
end
