module PdfTempura
  
  class Document::Table
    attr_accessor :height,:x,:y,:columns,:name,:row_height,:padding,:cell_padding
    
    
    def initialize(name,origin,options = {},&block)
      @name = name
      (@x,@y) = origin
      @options = options
      @columns = []
      
      load_options(options)
      instance_eval(&block) if block_given?
    end
    
    def text_column(name,width,options = {})
      @columns << Document::Table::TextColumn.new(name,width,row_height,options)
    end
    
    def checkbox_column(name,width,options = {})
      @columns << Document::Table::CheckboxColumn.new(name,width,row_height,options)
    end
    
    def spacer(width)
      @columns << Document::Table::Spacer.new(width,row_height)
    end
    
    def width
      if @columns.empty?
        0
      else
        @columns.map(&:width).inject(:+) + @cell_padding*(@columns.count-1)
      end
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
      
      @padding = options[:padding] || [0,0,0,0]
      @cell_padding = options[:cell_padding] || 0
    end
  end
  
  
end

require_relative 'table/column'
require_relative 'table/text_column'
require_relative 'table/checkbox_column'
require_relative 'table/spacer'