module PdfTempura
  class Document::Table::TextColumn < Document::Table::Column

    def field_at(coordinates)
      PdfTempura::Document::TextField.new(name, coordinates, [width, height], options)
    end

  end
end
