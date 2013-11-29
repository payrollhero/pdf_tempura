require 'tempfile'

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

        # write the pdf to it

        tempfile.rewind
        yield(tempfile)
      ensure
        tempfile.unlink
      end
    end

  end
end
