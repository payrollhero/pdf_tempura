require 'spec_helper'

describe PdfTempura do

  describe "integration" do

    class MyDocument < PdfTempura::Document
      template "spec/assets/sample_pdf_form.pdf"

      debug :outlines
      debug :grid

      page 1 do
        field "name", [193,641.5], [311.5,25], padding: [0,5,0,5]
        field "email", [193,602], [311.5,25.25], padding: [0,5,0,5], bold: true, font_name: "Courier"
        field "reason", [54,481], [502,311], padding: [5,5,5,5], multi_line: true, font_size: 18
      end

      page 2 do
        field "bar", [50,680], [40,35]
      end
    end

    let(:data) do
      {
        1 => {
          "name" => (["John Doe"] * 10).join(' '),
          "email" => "john@doe.com",
          "reason" => "
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ultrices tortor leo. Nunc convallis erat vitae lorem elementum, vel blandit odio scelerisque. Maecenas a cursus nunc. Duis lectus velit, porta eget rhoncus ut, posuere eu nisl. Maecenas imperdiet eget sem sit amet pellentesque. Mauris eu sodales est. Mauris quis quam eu nisl luctus scelerisque sit amet faucibus urna. Morbi sagittis, ligula quis ullamcorper tempus, ante mi gravida urna, ac facilisis tortor nisl ac turpis.

          Nam adipiscing urna mauris, sed mollis enim malesuada non. Praesent non tellus blandit, rhoncus elit non, semper sem. Nam mollis tristique velit vehicula dignissim. Donec adipiscing, odio a ornare ultricies, tortor dolor condimentum sem, sed consectetur mi lorem in nunc. Aliquam at accumsan urna, ut dapibus dolor. In bibendum vitae velit quis tristique. Duis cursus pulvinar arcu, in mollis augue eleifend eget. Nam et est non ipsum congue placerat euismod eu justo. Aenean facilisis eu mi sed condimentum. Maecenas posuere lorem lectus, eu condimentum justo mattis ut. In fringilla feugiat tortor nec elementum.
          ",
        },
        2 => {
          "bar" => "123",
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
