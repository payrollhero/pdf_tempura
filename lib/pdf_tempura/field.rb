require 'active_support/hash_with_indifferent_access'
require_relative 'field/validation'

module PdfTempura
  class Field
    include Validation

    def initialize(name, coordinates, dimensions, options = {})
      @name = name
      @coordinates = coordinates
      @dimensions = dimensions
      @options = options

      validate_arguments
    end

    attr_reader :coordinates, :dimensions

    def name
      @name.to_s
    end

    def options
      ActiveSupport::HashWithIndifferentAccess.new.merge @options
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

    def type
      (options["type"] || "text").to_s
    end

    def default_value
      options["default_value"]
    end

    def font_size
      options["font_size"] || 10
    end

    def bold?
      !!options["bold"]
    end

    def alignment
      (options["alignment"] || "left").to_s
    end

    def multi_line?
      !!options["multi_line"]
    end

    def padding
      options["padding"] || [0,0,0,0]
    end

  end
end
