require 'spec_helper'

describe PdfTempura::Render::FieldDataMapper do

  let(:fields) do
    [
      PdfTempura::Document::TextField.new("one", [0,0], [0,0]),
      PdfTempura::Document::TextField.new("bar", [0,0], [0,0]),
      PdfTempura::Document::TextField.new("baz", [0,0], [0,0]),
    ]
  end

  let(:data) do
    {
      "one" => "a1",
      "bar" => "a2",
      "bla" => "a4",
    }
  end

  describe ".map" do
    example do
      described_class.map(fields, data).should == {
        fields[0] => "a1",
        fields[1] => "a2",
        fields[2] => nil,
      }
    end
  end

end
