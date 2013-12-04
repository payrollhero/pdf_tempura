module PdfTempura
  class Document::Table::CheckboxColumn < Document::Table::Column
    
    def render_at(pdf,coords,value)
      field = Document::CheckboxField.new(name,coords,options)
      Render::TextField.new(field,value,options).render(pdf)
    end
  end
end
