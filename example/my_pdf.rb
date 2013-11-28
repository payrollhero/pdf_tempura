class MyPdf < PdfTempura::Document

  template "/some/path/to/template.pdf"

  group :employee_details do
    field :first_name, [10, 20], [100, 30]
    field :surname, [120, 20], [200, 30], { bold: true }
    field :company, [330, 20], [300, 30], { alignment: right }
  end

  page 1 do
    include_group :employee_details
    field :address, [10, 20], [500, 60]
  end

  page 2 do
    include_group :employee_details
    field :emergency_contact, [10, 20], [500, 60]
  end

end
