module PdfTempura
  class Document::BoxedCharacterField < Document::Field::Base

    attr_reader :box_width, :box_spacing, :groups

    validates :box_width, required: true, type: Numeric
    validates :box_spacing, required: true, type: Numeric
    
    def initialize(name,coordinates,dimensions,options = {},&block)
      super(name,coordinates,dimensions,options)
      @groups = []
      
      instance_eval(&block) if block_given?
    end
    
    def characters(characters)
      @groups << CharacterGroup.new(characters)
    end
    
    def space(width)
      @groups << SpaceGroup.new(width)
    end
    
    def supported_characters
      @groups.map(&:characters).inject(:+)
    end
    
    private

    def load_options(options)
      @box_width = options["box_width"]
      @box_spacing = options["box_spacing"]
    end
    
    class CharacterGroup
      include Document::Validation
      attr_reader :characters
      validates :characters, type: Numeric
      def initialize(characters)
        @characters = characters
        validate!
      end
      def spacing
        0
      end
    end
    
    class SpaceGroup
      include Document::Validation
      attr_reader :spacing
      validates :spacing, type: Numeric
      def initialize(units)
        @spacing = units
        validate!
      end
      def characters
        0
      end
    end

  end
end