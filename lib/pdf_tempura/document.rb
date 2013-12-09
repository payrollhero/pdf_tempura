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

      def repeatable
        @repeatable = true
      end

      def repeatable_option
        @repeatable || false
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
      new_renderer.render(&block)
    end

    private

    def repeatable
      self.class.repeatable_option
    end

    def new_renderer
      PdfTempura::Renderer.new(self.class.template_file_path,
        self.pages,
        { debug: self.class.debug_options,
          repeatable: self.class.repeatable_option,
          template_page_count: class_pages.count
        })
    end

    def generate_pages_from_data(data)
      data.each_with_index do |page_data,number|
        page = class_pages[number % class_pages.count ]
        self.pages << page.dup.tap{ |new_page|
          new_page.data = page_data || {}
        }
      end
      generate_missing_pages
    end

    def class_pages
      self.class.pages
    end

    def generate_missing_pages
      if pages.count % class_pages.count != 0
        [(pages.count % class_pages.count ) .. class_pages.count].each do |number|
          page = class_pages[number]
          self.pages << page.dup
        end
      end
    end

    def load_data(data)
      if !repeatable && data.keys.count > self.class.pages.count
        raise ArgumentError.new("There are more pages in the data than pages defined.  Use 'repeatable' to repeat template pages in the document class.")
      end

      data_for_pages = data.values_at(*(data.keys.select {|k| k.kind_of?(Numeric)}))
      generate_pages_from_data(data_for_pages)
    end

  end
end

require_relative 'document/validation'
require_relative 'document/page'
require_relative 'document/field/base'
require_relative 'document/character_field'
require_relative 'document/text_field'
require_relative 'document/checkbox_field'
require_relative 'document/table'
require_relative 'document/boxed_characters'
