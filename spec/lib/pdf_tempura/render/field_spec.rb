require 'spec_helper'

describe PdfTempura::Render::Field do

  describe ".generate" do
    let(:options) { {} }

    context "when passing a text field" do
      let(:field) { PdfTempura::Document::Field::Base.new("foo", [0,0], [0,0], type: "text") }

      it "returns a TextField object" do
        object = described_class.generate(field, "foo", options)
        object.should be_kind_of(PdfTempura::Render::TextField)
      end
    end

    context "when passing a diffrent field" do
      let(:field) { PdfTempura::Document::Field::Base.new("foo", [0,0], [0,0], type: "stars") }

      it "raises an ArgumentError" do
        expect {
          described_class.generate(field, "foo", options)
        }.to raise_exception(ArgumentError)
      end
    end
  end

end
