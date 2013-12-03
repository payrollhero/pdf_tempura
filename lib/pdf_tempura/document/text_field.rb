module PdfTempura
  class Document::TextField < Document::Field::Base

    attr_reader :font_name, :font_size, :alignment, :bold, :italic, :multi_line, :padding

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

    private

    def load_options(options)
      super

      @font_name = options["font_name"] || "Helvetica"
      @font_size = options["font_size"] || 10
      @bold = options["bold"] || false
      @italic = options["italic"] || false
      @bold = options["bold"] || false
      @alignment = (options["alignment"] || "left").to_s
      @multi_line = options["multi_line"] || false
      @padding = options["padding"] || [0,0,0,0]
    end

  end
end
