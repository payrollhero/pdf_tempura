require 'spec_helper'

describe PdfTempura::Render::TextField do

  let(:field) { PdfTempura::Field.new("foo", [0,0], [0,0], type: "text") }

  describe "initialize" do
    example do
      expect {
        described_class.new(field, "foo")
      }.not_to raise_exception
    end
  end

  describe "#render" do
    it "works"
  end

end
