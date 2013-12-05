module PdfTempura
  class Document::Table::Spacer < Document::Table::Column

    def initialize(width, height)
      super(nil, width, height)
    end

    def generates_field?
      false
    end

  end
end
