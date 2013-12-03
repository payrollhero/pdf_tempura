module PdfTempura
  class Document::CheckboxField < Document::Field::Base

    attr_reader :default_value

    validates :default_value, inclusion: [true, false]

    def load_options(options)
      @default_value = options["default_value"] || false
    end

  end
end
