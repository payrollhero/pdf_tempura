class MyPdf < PdfTempura::Document
  template "spec/assets/sample_pdf_form.pdf"

  debug :outlines
  debug :grid
  repeatable

  page 1 do
    text_field "name", [193,641.5], [311.5,25], padding: [0,5,0,5]
    text_field "email", [193,602], [311.5,25.25], padding: [0,5,0,5], bold: true, font_name: "Courier"
    text_field "reason", [54,481], [502,311], padding: [5,5,5,5], multi_line: true, font_size: 18
    checkbox_field "accept", [192,554], [22,22]

    boxed_characters "pin", [139,146], 20, box_width: 19.75, box_spacing: 0 do
      characters 2
      space 8.5
      characters 3
      space 8
      characters 2
    end
  end

  page 2 do
    table "table", [57,688], number_of_rows: 16, height: 550,cell_padding: 1 do
      text_column "id",42, alignment: "center"
      text_column "name",232, padding: [5,5,5,5]
      text_column "email",224, padding: [5,5,5,5]
    end

    field_set "form" do
      text_field "id", [122,60], [125,27], padding: [5,5,5,5], font_size: 2
    end
  end

end
