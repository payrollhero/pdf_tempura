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
        page.instance_eval &block
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
      @data = data
    end

    attr_reader :data

    def render
      # add render integration here
    end

  end
end
