module PdfTempura
  class Document::Table::TextColumn < Document::Table::Column
    
    def field_at(coords)
      PdfTempura::Document::TextField.new(name,coords,[width,height],options)
    end
  end
end
