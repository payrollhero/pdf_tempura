require 'spec_helper'

describe PdfTempura do

  describe "integration" do

    class MyDocument < PdfTempura::Document
      template "spec/assets/sample_pdf_form.pdf"

      page 1 do
        field "name", [0,0], [100,100]
      end
    end

    let(:data) do
      {
        1 => {
          "name" => "John Doe",
        }
      }
    end

    example do
      FileUtils.mkdir_p("tmp")
      MyDocument.new(data).render do |file|
        File.open("tmp/integration.pdf", "w") do |fh|
          fh.write(file.read)
        end
      end
    end

  end

end
