require 'tempfile'
require 'prawn'

module PdfTempura
  class Renderer

    def initialize(template_path, pages, options = {})
      @template_path = template_path
      @pages = pages
      @options = options
      @template_page_count = options[:template_page_count] || @pages.count
    end

    def render_into(pdf)
      @pages.to_enum.with_index(0).each do |page, index|
        pdf.start_new_page template: @template_path, template_page: ((index % @template_page_count) + 1)
        Render::Page.new(page,@options).render(pdf)
      end
    end

    def render
      tempfile = Tempfile.new(["render",".pdf"],:encoding => 'ascii-8bit')

      begin
        pdf = Prawn::Document.new(skip_page_creation: true, margin: 0)

        render_into(pdf)

        tempfile.write pdf.render
        tempfile.rewind

        yield tempfile
      ensure
        tempfile.unlink
      end
    end

  end
end
