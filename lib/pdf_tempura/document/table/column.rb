module PdfTempura
  class Document::Table::Column
    attr_reader :name,:width,:type
    
    def initialize(name,width,options = {})
      @name = name
      @width = width
      @type = options[:type]
      
      raise ArgumentError.new("You must specify a :type for this column.") unless @type
    end
  end
  
end
