module PdfTempura
  
  class Document::Table
    attr_accessor :width,:height,:x,:y,:columns,:name,:row_height
    
    
    def initialize(name,origin,options = {},&block)
      @name = name
      (@x,@y) = origin
      @options = options
      @columns = []
      
      load_options(options)
      instance_eval(&block) if block_given?
    end
    
    def column(name,width,options)
      @columns << Document::Table::Column.new(name,width,options)
    end
    
    def spacer(width)
      @columns << Document::Table::Spacer.new(width)
    end
    
    private
    
    def load_options(options)
      @height = options[:height]
      @row_height = options[:row_height]
      @row_count = options[:number_of_rows]
      
      unless @row_count && (@row_height || @height)
        raise ArgumentError.new("You must pass number_of_rows and either height or row_height")
      end
      
      unless @height
        @height = @row_height * @row_count
      end
      
      unless @row_height
        @row_height = @height / @row_count
      end
    end
  end
  
  
end

require_relative 'table/column'
require_relative 'table/spacer'