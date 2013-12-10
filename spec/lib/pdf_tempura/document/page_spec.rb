require 'spec_helper'

describe PdfTempura::Document::Page do

  subject{ described_class.new(100) }

  its(:number){ should == 100 }
  its(:fields){ should == [] }

  it_behaves_like "a field that accepts default commands"

  describe "#validation" do

    context "when passed an invalid page number" do
      it "raise an argument error" do
        expect{
          described_class.new("one")
        }.to raise_error ArgumentError, "Number must be of type Numeric."
      end
    end

    context "when passed a valid page number" do
      it "returns a Page object" do
        described_class.new(1).should be_a(described_class)
      end
    end

  end

  describe "#==" do
    context "when they have the same page number" do
      let(:other){ described_class.new(100) }

      it{ should == other }
    end

    context "when they have different page numbers" do
      let(:other){ described_class.new(200) }

      it{ should_not == other }
    end
  end

  describe "#data" do
    let(:data){ { woo: "yes"} }

    it "returns an empty hash when it has no data" do
      subject.data == {}
    end

    it "returns the data" do
      subject.data = { name: "Bruce" }
      subject.data.should == { "name" => "Bruce" }
    end
  end

end
