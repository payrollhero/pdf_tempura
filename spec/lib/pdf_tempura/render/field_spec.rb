require 'spec_helper'

describe PdfTempura::Render::Field do

  describe ".generate" do
    let(:options) { {} }

    context "when passing a text field" do
      let(:field) { PdfTempura::Document::TextField.new("foo", [0,0], [0,0]) }

      it "returns a TextField object" do
        object = described_class.generate(field, "foo", options)
        object.should be_kind_of(PdfTempura::Render::TextField)
      end
    end
    
    context "when passing a table field" do
      let(:field) { PdfTempura::Document::Table.new("foo", [0,0], height: 100, number_of_rows: 10) }

      it "returns a Table object" do
        object = described_class.generate(field, "foo", options)
        object.should be_kind_of(PdfTempura::Render::Table)
      end
    end

    context "when passing a different field" do
      let(:field) { double(:different_field, type: "different")}

      it "raises an ArgumentError" do
        expect {
          described_class.generate(field, "foo", options)
        }.to raise_exception(ArgumentError)
      end
    end
  end

end
