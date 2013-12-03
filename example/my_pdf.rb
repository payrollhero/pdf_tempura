class MyPdf < PdfTempura::Document
  template "spec/assets/sample_pdf_form.pdf"

  debug :outlines
  debug :grid

  page 1 do
    text_field "name", [193,641.5], [311.5,25], padding: [0,5,0,5]
    text_field "email", [193,602], [311.5,25.25], padding: [0,5,0,5], bold: true, font_name: "Courier"
    text_field "reason", [54,481], [502,311], padding: [5,5,5,5], multi_line: true, font_size: 18
  end

  page 2 do
    text_field "bar", [50,680], [40,35]
  end

end
