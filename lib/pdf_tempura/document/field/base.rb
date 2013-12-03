module PdfTempura
  class Document::Field::Base
    include Document::Validation

    def initialize(name, coordinates, dimensions, options = {})
      @name = name.is_a?(Symbol) ? name.to_s : name
      @coordinates = coordinates
      @dimensions = dimensions

      convert_options_hash(options)

      @type = (options["type"] || "text").to_s
      @default_value = options["default_value"]
      @font_name = options["font_name"] || "Helvetica"
      @font_size = options["font_size"] || 10
      @bold = options["bold"] || false
      @italic = options["italic"] || false
      @alignment = (options["alignment"] || "left").to_s
      @multi_line = options["multi_line"] || false
      @padding = options["padding"] || [0,0,0,0]

      validate!
    end

    attr_reader :coordinates, :dimensions, :name, :type, :default_value,
      :font_name, :font_size, :alignment, :bold, :italic, :multi_line, :padding

    alias_method :bold?, :bold
    alias_method :italic?, :italic
    alias_method :multi_line?, :multi_line

    validates :name, type: String
    validates :type, inclusion: ["text", "checkbox", "box-list"]
    validates :coordinates, type: Array, inner_type: Numeric, count: 2
    validates :dimensions, type: Array, inner_type: Numeric, count: 2
    validates :font_name, type: String
    validates :font_size, type: Numeric
    validates :bold, inclusion: [true, false]
    validates :italic, inclusion: [true, false]
    validates :alignment, inclusion: ["left", "right", "center"]
    validates :multi_line, inclusion: [true, false]
    validates :padding, type: Array, inner_type: Numeric, count: 4

    def x
      coordinates.first
    end

    def y
      coordinates.last
    end

    def width
      dimensions.first
    end

    def height
      dimensions.last
    end

    def convert_options_hash(options)
      if options.is_a?(Hash)
        options.extend(Extensions::Hash::StringifyKeys).stringify_keys!
      else
        raise ArgumentError, "Options must be a hash."
      end
    end

  end
end
