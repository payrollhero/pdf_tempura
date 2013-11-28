require 'spec_helper'

describe PdfTempura::Render::TextField do

  # TODO: convert to real class objects
  #let(:field) { Field.new("foo", [0,0], [0,0], type: "text") }
  let(:field) { double("field", type: "text") }

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
