require 'tempfile'
require 'prawn'

module PdfTempura
  class Renderer

    def initialize(template_path, pages, data, options = {})
      @template_path = template_path
      @pages = pages
      @data = data
      @options = options
    end

    def render
      tempfile = Tempfile.new("render")
      begin

        pdf = Prawn::Document.new(template: @template_path)

        @pages.each do |page|
          Render::Page.new(page, @data[page.number]).render(pdf)
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
