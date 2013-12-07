module PdfTempura
  class Document::BoxedCharacters::CharacterGroup
    include Document::Validation
    attr_reader :characters
    validates :characters, type: Numeric
    def initialize(characters)
      @characters = characters
      validate!
    end
    def spacing
      0
    end
    def each_supported_character(&block)
      characters.times {yield}
    end
  end

  class Document::BoxedCharacters::SpaceGroup
    include Document::Validation
    attr_reader :spacing
    validates :spacing, type: Numeric
    def initialize(units)
      @spacing = units
      validate!
    end
    def characters
      0
    end
    def each_supported_character(&block)
      #we support no characters, nein!
    end
  end
end
