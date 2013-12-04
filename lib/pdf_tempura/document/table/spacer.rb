module PdfTempura
  class Document::Table::Spacer < Document::Table::Column
    def initialize(width,height)
      super(nil,width,height)
    end
    
    def render(pdf,coords,value,render_options = {})
      #this area intentionally left blank
    end
  end
end
