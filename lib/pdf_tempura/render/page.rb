module PdfTempura
  module Render
    class Page

      include OptionAccess

      def initialize(page, data, options = {})
        @page = page
        @data = data
        @options = options
      end

      def render(pdf)
        pdf.go_to_page(@page.number)
        Render::Page::GridRenderer.new.render(pdf) if draw_grid?
        pairs = Render::FieldDataMapper.map(@page.fields, @data)
        pairs.each do |(field, value)|
          Render::Field.generate(field, value, @options).render(pdf)
        end
      end

    end
  end
end

require_relative 'page/grid_renderer'
