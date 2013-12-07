require 'spec_helper'
require_relative '../example/my_pdf'

describe PdfTempura do

  describe "integration" do

    let(:data) do
      {
        1 => {
          "name" => (["John Doe"] * 10).join(' '),
          "email" => "john@doe.com",
          "accept" => true,
          "pin" => "2233322",
          "reason" => "
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ultrices tortor leo. Nunc convallis erat vitae lorem elementum, vel blandit odio scelerisque. Maecenas a cursus nunc. Duis lectus velit, porta eget rhoncus ut, posuere eu nisl. Maecenas imperdiet eget sem sit amet pellentesque. Mauris eu sodales est. Mauris quis quam eu nisl luctus scelerisque sit amet faucibus urna. Morbi sagittis, ligula quis ullamcorper tempus, ante mi gravida urna, ac facilisis tortor nisl ac turpis.

          Nam adipiscing urna mauris, sed mollis enim malesuada non. Praesent non tellus blandit, rhoncus elit non, semper sem. Nam mollis tristique velit vehicula dignissim. Donec adipiscing, odio a ornare ultricies, tortor dolor condimentum sem, sed consectetur mi lorem in nunc. Aliquam at accumsan urna, ut dapibus dolor. In bibendum vitae velit quis tristique. Duis cursus pulvinar arcu, in mollis augue eleifend eget. Nam et est non ipsum congue placerat euismod eu justo. Aenean facilisis eu mi sed condimentum. Maecenas posuere lorem lectus, eu condimentum justo mattis ut. In fringilla feugiat tortor nec elementum.
          ",
        },
        2 => {
          "form_id" => "123",
          "table" => [
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
            {"id" => "1","name" => "one", "email" => "one@theone.com"},
            {"id" => "2","name" => "two", "email" => "two@theone.com"},
          ]
        }
      }
    end

    example do
      FileUtils.mkdir_p("tmp")
      MyPdf.new(data).render do |file|
        File.open("tmp/integration.pdf", "w") do |fh|
          fh.write(file.read)
        end
      end
    end

  end

end
