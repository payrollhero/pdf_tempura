module PdfTempura
  class Document::Table::TextColumn < Document::Table::Column
    
    def render_at(pdf,coords,value,render_options = {})
      field = Document::TextField.new(name,coords,[width,height],options)
      Render::TextField.new(field,value,render_options).render(pdf)
    end
  end
end
