module PdfTempura
  class Document::Table::Column
    attr_reader :name,:width,:options,:height
    
    def initialize(name,width,height,options = {})
      @name = name
      @width = width
      @height = height
      @options = options
    end
    
    def render(pdf,coords,value_hash,render_options = {})
      render_at(pdf,coords,value_hash[@name],render_options)
    end
  end
  
end
