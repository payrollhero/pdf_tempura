require 'tempfile'
require 'prawn'

module PdfTempura
  class Renderer

    def initialize(template_path, pages, options = {})
      @template_path = template_path
      @pages = pages
      @options = options
    end
    
    def render_into(pdf)
      @pages.to_enum.with_index(1).each do |page, i|
        pdf.start_new_page template: @template_path, template_page: i
        Render::Page.new(page,@options).render(pdf)
      end
    end

    def render
      tempfile = Tempfile.new("render")

      begin
        pdf = Prawn::Document.new(skip_page_creation: true, margin: 0)

        render_into(pdf)

        tempfile.write pdf.render
        tempfile.rewind
        yield(tempfile)
      ensure
        tempfile.unlink
      end
    end

  end
end
