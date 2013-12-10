module PdfTempura
  class Document::Table::Column

    attr_reader :name, :width, :options, :height

    def initialize(name, width, height, options = {})
      @name = name
      @width = width
      @height = height
      @options = options
    end

    def generates_field?
      true
    end

  end
end
