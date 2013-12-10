module PdfTempura
  module Render
    class FieldSet
      include OptionAccess

      def initialize(set, data, options = {})
        @set = set
        @data = data
        @options = options
      end

      def render(pdf)
        render_debug_annotation(pdf) if draw_outlines?

        pairs = Render::FieldDataMapper.map(@set.fields, @data)

        pairs.each do |(field, value)|
          Render::Field.generate(field, value, @options).render(pdf)
        end
      end

      private

      def render_debug_annotation(pdf)
        Debug::FieldSetAnnotation.new(@set).render(pdf)
      end
    end
  end
end

