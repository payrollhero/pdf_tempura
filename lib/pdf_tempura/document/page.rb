module PdfTempura
  class Document::Page
    include Document::Validation

    def initialize(page_number)
      @number = page_number
      @fields = []

      validate!
    end

    attr_reader :number, :fields

    validates :number, type: Numeric

    def ==(other)
      self.number == other.number
    end

    def text_field(name, coordinates, dimensions, options = {})
      fields << Document::TextField.new(name, coordinates, dimensions, options)
    end

    def checkbox_field(name, coordinates, dimensions, options = {})
      fields << Document::CheckboxField.new(name, coordinates, dimensions, options)
    end

    def table(name, coordinates, options = {}, &block)
      fields << Document::Table.new(name, coordinates, options, &block)
    end

    def boxed_characters(name,coordinates,height, options = {},&block)
      fields << Document::BoxedCharacters.new(name,coordinates,height,options,&block)
    end

    def data
      @data ||= {}
    end

    def data=(data)
      @data = data.extend(Extensions::Hash::StringifyKeys).stringify_keys!
    end

  end
end
