module PdfTempura
  module Document::Validation

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def validations
        @validations ||= (superclass.respond_to?(:validations) ? superclass.validations.dup : {})
      end

      private

      def validates(name, validation_options)
        if self.instance_methods.include?(name)
          validations[name] = validation_options
        else
          raise NoMethdError, "Can't validate undefined method '#{method}'."
        end
      end
    end

    private

    def validate!
      self.class.validations.each do |method, validation_options|
        validation_options.each do |validation_type, values|
          find_validator(validation_type).new.validate(self, method, values)
        end
      end
    end

    def find_validator(validation_type)
      validator_name = validation_type.to_s.split("_").push("validator").map(&:capitalize).join
      Document::Validation.const_get(validator_name)
    end

    class RequiredValidator
      def validate(object, method, not_used)
        raise ArgumentError, "#{method.capitalize} is required." unless object.send(method)
      end
    end

    class BooleanValidator
      def validate(object, method, not_used)
        raise ArgumentError, "#{method.capitalize} must be of type boolean." unless object.send(method).is_a?(TrueClass) || object.send(method).is_a?(FalseClass)
      end
    end

    class InclusionValidator
      def validate(object, method, values)
        raise ArgumentError, "#{method.capitalize} must be one of the following values: #{values.join(", ")}." unless values.include?(object.send(method))
      end
    end

    class TypeValidator
      def validate(object, method, type)
        raise ArgumentError, "#{method.capitalize} must be of type #{type.inspect}." unless object.send(method).is_a?(type)
      end
    end

    class InnerTypeValidator
      def validate(object, method, type)
        raise ArgumentError, "#{method.capitalize} must contain only #{type.inspect} values." unless object.send(method).all?{ |inner| inner.is_a?(type) }
      end
    end

    class CountValidator
      def validate(object, method, count)
        count_objects = object.send(method)
        raise ArgumentError, "#{method.capitalize} must contain #{count} values." unless count_objects.respond_to?(:count) && count_objects.count == count
      end
    end

  end
end
