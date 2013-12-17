module PdfTempura
  class Document::FieldSet
    include Document::Validation
    include Document::DefaultCommands

    attr_reader :name

    validates :name, type: String

    def initialize(name,options = {},&block)
      @name = name
      @fields = []
      @default_options = options[:default_options] || {}

      instance_eval(&block) if block_given?
      validate!
    end

    def coordinates
      [x,y]
    end

    def dimensions
      [width,height]
    end

    def x
      fields.map(&:x).min || 0
    end

    def y
      fields.map(&:y).max || 0
    end

    def width
      return 0 if fields.empty?
      fields.map{|field| field.x + field.width}.max - x
    end

    def height
      return 0 if fields.empty?
      y - fields.map{|field| field.y - field.height}.min
    end

    def padding
      [0,0,0,0]
    end

  end
end

