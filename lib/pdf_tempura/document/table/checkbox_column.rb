module PdfTempura
  class Document::Table::CheckboxColumn < Document::Table::Column

    def field_at(coordinates)
      return Document::CheckboxField.new(name, coordindates, options)
    end

  end
end
