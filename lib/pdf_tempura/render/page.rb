module PdfTempura
  module Render
    class Page

      include OptionAccess

      def initialize(page, options = {})
        @page = page
        @options = options
      end

      def render(pdf)
        pdf.go_to_page(@page.number)
        Render::Page::GridRenderer.new.render(pdf) if draw_grid?
        pairs = Render::FieldDataMapper.map(@page.fields, @page.data)
        pairs.each do |(field, value)|
          Render::Field.generate(field, value, @options).render(pdf)
        end
      end

    end
  end
end

require_relative 'page/grid_renderer'
