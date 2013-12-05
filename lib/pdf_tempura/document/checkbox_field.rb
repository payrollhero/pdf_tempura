module PdfTempura
  class Document::CheckboxField < Document::Field::Base

    attr_reader :default_value, :padding

    validates :default_value, inclusion: [true, false]
    validates :padding, type: Array, inner_type: Numeric, count: 4

    def load_options(options)
      @default_value = options["default_value"] || false
      @padding = options["padding"] || [1,1,1,1]
    end

  end
end
