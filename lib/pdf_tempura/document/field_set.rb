module PdfTempura
  class Document::FieldSet
    include Document::Validation
    include Document::DefaultCommands

    attr_reader :name
    validates :name, type: String

    def initialize(name,&block)
      @name = name
      @fields = []

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
      return 0 if fields.empty?
      fields.map(&:x).min
    end

    def y
      return 0 if fields.empty?
      fields.map(&:y).min
    end

    def width
      return 0 if fields.empty?
      fields.map {|f| f.x + f.width}.max  - x
    end

    def height
      return 0 if fields.empty?
      fields.map {|f| f.y + f.height}.max - y
    end

    def padding
      [0,0,0,0]
    end

  end
end

