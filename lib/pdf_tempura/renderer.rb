require 'tempfile'
require 'prawn'

module PdfTempura
  class Renderer

    def initialize(template_path, pages, options = {})
      @template_path = template_path
      @pages = pages
      @options = options
    end

    def render
      tempfile = Tempfile.new("render")

      begin
        pdf = Prawn::Document.new(template: @template_path, margin: 0)

        @pages.each do |page|
          Render::Page.new(page, @options).render(pdf)
        end

        tempfile.write pdf.render
        tempfile.rewind
        yield(tempfile)
      ensure
        tempfile.unlink
      end
    end

  end
end
