module PdfTempura
  class Document::Table::CheckboxColumn < Document::Table::Column
    
    def field_at(coords)
      return Document::CheckboxField.new(name,coords,options)
    end
  end
end
