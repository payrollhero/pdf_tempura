require_relative 'character_field'

module PdfTempura
  class Document::TextField < Document::CharacterField
    private

    def load_options(options)
      super

      @alignment = (options["alignment"] || "left").to_s
      @multi_line = options["multi_line"] || false
      @valign = options["valign"] || "center"
      @leading = options["leading"] || 0
    end

  end
end
