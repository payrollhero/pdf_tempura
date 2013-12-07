module PdfTempura
  class Document::CharacterField < Document::Field::Base

    attr_reader :default_value, :font_name, :font_size, :bold, :italic, :padding,
      :alignment, :multi_line

    alias_method :bold?, :bold
    alias_method :italic?, :italic
    alias_method :multi_line?, :multi_line

    validates :font_name, type: String
    validates :font_size, type: Numeric
    validates :bold, inclusion: [true, false]
    validates :italic, inclusion: [true, false]
    validates :alignment, inclusion: ["left", "right", "center"]
    validates :multi_line, inclusion: [true, false]
    validates :padding, type: Array, inner_type: Numeric, count: 4
    validates :default_value, type: String

    private

    def load_options(options)
      @default_value = options["default_value"] || ""
      @font_name = options["font_name"] || "Helvetica"
      @font_size = options["font_size"] || 10
      @bold = options["bold"] || false
      @italic = options["italic"] || false
      @bold = options["bold"] || false
      @padding = options["padding"] || [0,0,0,0]
      @alignment = "center"
      @multi_line = false
    end

  end
end
