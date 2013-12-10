module PdfTempura
  class Document::Table::CheckboxColumn < Document::Table::Column

    def field_at(coordinates)
      Document::CheckboxField.new(name, coordinates, [width,height], options)
    end

  end
end
