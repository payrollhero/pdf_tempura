module PdfTempura
  module Render
    class Page

      def initialize(page, data)
        @page = page
        @data = data
      end

      def render(pdf)
        pdf.go_to_page(@page.number)
        pairs = Render::FieldDataMapper.map(@page.fields, @data)
        pairs.each do |(field, value)|
          Render::Field.generate(field, value).render(pdf)
        end
      end

    end
  end
end
