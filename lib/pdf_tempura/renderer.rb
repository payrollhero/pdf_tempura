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
        tempfile.write pdf.render

        # write the pdf to it

        tempfile.rewind
        yield(tempfile)
      ensure
        tempfile.unlink
      end
    end

  end
end
