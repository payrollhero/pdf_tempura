require 'spec_helper'

describe PdfTempura::Render::Field do

  describe ".generate" do

    context "when passing a text field" do
      # TODO: update to use actual class
      #let(:field) { Field.new("foo", [0,0], [0,0], type: "text") }
      let(:field) { double(:field, :kind => :text) } # temporary until Field class exists

      it "returns a TextField object" do
        object = described_class.generate(field, "foo")
        object.should be_kind_of(PdfTempura::Render::TextField)
      end
    end

    context "when passing a diffrent field" do
      # TODO: update to use actual class
      #let(:field) { Field.new("foo", [0,0], [0,0], type: "stars") }
      let(:field) { double(:field, :kind => :stars) } # temporary until Field class exists

      it "raises an ArgumentError" do
        expect {
          described_class.generate(field, "foo")
        }.to raise_exception(ArgumentError)
      end
    end

  end

end
