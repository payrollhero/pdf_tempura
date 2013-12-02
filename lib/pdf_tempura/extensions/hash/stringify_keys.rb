module PdfTempura
  module Extensions
    module Hash
      module StringifyKeys

        def stringify_keys
          dup.extend(StringifyKeys).stringify_keys!
        end

        def stringify_keys!
          keys.each do |k|
            stringify_keys_recursively!(self[k])
            self[k.to_s] = self.delete(k)
          end

          self
        end

        private

        def stringify_keys_recursively!(object)
          object.extend(StringifyKeys) if object.is_a?(::Hash)

          if object.respond_to?(:stringify_keys!)
            object.stringify_keys!
          else
            object.each{ |o| stringify_keys_recursively!(o) } if object.is_a?(::Array)
            object
          end
        end
      end

    end
  end
end
