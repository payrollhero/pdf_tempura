module PdfTempura
  class Document

    class << self

      def template_file_path
        @template_file_path
      end

      def template(path)
        raise ArgumentError, "Template path must be a string." unless path.is_a?(String)
        @template_file_path = path
      end

      def pages
        @pages ||= []
      end

      def page(page_number, &block)
        page = Page.new(page_number)
        pages << page
        page.instance_eval(&block)
        nil
      end

      def debug_options
        @debug_options ||= []
      end

      def debug(*options)
        debug_options.concat options
      end

    end

    def initialize(data = {})
      load_data(data)
    end

    def pages
      @pages ||= []
    end

    def render(&block)
      PdfTempura::Renderer.new(self.class.template_file_path, self.pages, { debug: self.class.debug_options }).render(&block)
    end

    private

    def load_data(data)
      self.class.pages.each do |page|
        self.pages << page.dup.tap{ |new_page|
          new_page.data = data[page.number] || {}
        }
      end
    end

  end
end

require_relative 'document/validation'
require_relative 'document/page'
require_relative 'document/field'
require_relative 'document/text_field'
