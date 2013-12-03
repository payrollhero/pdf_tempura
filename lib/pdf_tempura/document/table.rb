module PdfTempura
  
  class Document::Table
    attr_accessor :width,:height,:x,:y,:cells,:name
    
    
    def initialize(name,origin,options = {})
      @name = name
      (@x,@y) = origin
      @options = options
      
      load_options(options)
    end
    
    private
    
    def load_options(options)
      @height = options[:height]
      @row_height = options[:row_height]
      @row_count = options[:number_of_rows]
      
      unless @row_count && (@row_height || @height)
        raise ArgumentError.new("You must pass number_of_rows and either height or row_height")
      end
    end
  end
  
  
end