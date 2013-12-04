module PdfTempura
  class Document::Table::Spacer
    attr_reader :width
    
    def initialize(width)
      @width = width
    end
    
    def type
      "spacer"
    end
  end
  
end
