module PdfTempura
  class Document::Field::Base
    include Document::Validation

    def initialize(name, coordinates, dimensions, options = {})
      @name = name.is_a?(Symbol) ? name.to_s : name
      @coordinates = coordinates
      @dimensions = dimensions

      convert_options_hash(options)
      load_options(options)

      validate!
    end

    attr_reader :coordinates, :dimensions, :name, :default_value

    validates :name, type: String
    validates :coordinates, type: Array, inner_type: Numeric, count: 2
    validates :dimensions, type: Array, inner_type: Numeric, count: 2

    def type
      raise NotImplementedError, "Implement method 'type' in your subclass."
    end

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

    private

    def load_options(options)
      @default_value = options["default_value"]
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
