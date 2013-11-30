module PdfTempura
  class Field
    module Validation

      OPTIONS = ["type", "default_value", "font_size", "bold", "alignment", "multi_line", "padding"]

      private

      def validate_arguments
        [:name, :coordinates, :dimensions, :options].each do |argument|
          self.send("validate_#{argument}".to_sym)
        end
      end

      def validate_name
        raise ArgumentError, "Name must be a string or symbol." unless [String, Symbol].include?(@name.class)
      end

      def validate_coordinates
        if !(coordinates.is_a?(Array) && coordinates.count == 2 && x.is_a?(Numeric) && y.is_a?(Numeric))
          raise ArgumentError, "Coordinates must be an array containing two numbers, one for the x position and one for the y position."
        end
      end

      def validate_dimensions
        if !(dimensions.is_a?(Array) && dimensions.count == 2 && width.is_a?(Numeric) && height.is_a?(Numeric))
          raise ArgumentError, "Dimensions must be an array containing two numbers, one for the width and one for the height."
        end
      end

      def validate_options
        raise ArgumentError, "Options must be a hash." unless @options.is_a?(Hash)
        validate_options_keys
        validate_options_values
      end

      def validate_options_keys
        extra_options = options.reject{ |key, value| OPTIONS.include?(key) }
        raise ArgumentError, "Options hash contains an unknown option '#{extra_options.keys.first}'." if extra_options.any?
      end

      def validate_options_values
        options.each_key do |option|
          self.send("validate_#{option}")
        end
      end

      def validate_type
        raise ArgumentError, "Option 'type' must be either 'text', 'checkbox' or 'box-list'." unless ["text", "checkbox", "box-list"].include?(type)
      end

      def validate_default_value
        raise ArgumentError, "Option 'default_value' is not valid for the type '#{type}'." unless valid_types_for_default_value.include?(default_value.class)
      end

      def valid_types_for_default_value
        case type
        when "text", "box-list"
          [String]
        when "checkbox"
          [TrueClass, FalseClass]
        else
          []
        end
      end

      def validate_font_size
        raise ArgumentError, "Option 'font_size' must be a number." unless font_size.is_a?(Numeric)
      end

      def validate_bold
        raise ArgumentError, "Option 'bold' must be true or false." unless [TrueClass, FalseClass, NilClass].include?(options["bold"].class)
      end

      def validate_alignment
        raise ArgumentError, "Option 'alignment' must be either 'left', 'right' or 'center'." unless ["left", "right", "center"].include?(alignment)
      end

      def validate_multi_line
        raise ArgumentError, "Option 'multi_line' must be true or false." unless [TrueClass, FalseClass, NilClass].include?(options["multi_line"].class)
      end

      def validate_padding
        raise ArgumentError, "Option 'padding' must be an array containing 4 numbers, the top, right, bottom, left padding values." unless options["padding"].kind_of?(Array) && options["padding"].size == 4 && options["padding"].all? { |i| i.kind_of?(Numeric) }
      end

    end
  end
end
