module PdfTempura
  class Document::Table::BoxedCharacterColumn < Document::Table::Column

    def initialize(name, height, options = {}, &block)
      @name = name
      @height = height
      @options = options
      @block = block if block_given?
    end

    def width
      field_at([0,0]).width
    end

    def field_at(coordinates)
      PdfTempura::Document::BoxedCharacters.new(@name, coordinates, @height, @options, &@block)
    end

  end
end
