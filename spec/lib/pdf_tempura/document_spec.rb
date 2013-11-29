require 'spec_helper'

describe PdfTempura::Document do

  describe ".template" do
    it "sets the template file path" do
      described_class.template "/some/path/to/template.pdf"
      described_class.template_file_path.should == "/some/path/to/template.pdf"
    end

    it "raises an argument error if you send it something that's not a string" do
      expect{
        described_class.template [123]
      }.to raise_error ArgumentError, "Template path must be a string."
    end
  end

  describe ".page" do
    let(:page){ PdfTempura::Page.new(200) }

    it "yield a page object" do
      expect{ |block|
        described_class.page(200, &block)
      }.to yield_with_args(page)
    end

    it "passed method calls on to the new page object" do
      PdfTempura::Page.any_instance.should_receive(:fields)

      described_class.page(200) do
        fields
      end
    end

    it "adds the page object to the pages list" do
      expect{
        described_class.page(200){}
      }.to change(described_class.pages, :count).by(1)
    end
  end

  describe ".pages" do
    it "returns an array" do
      described_class.pages.should be_a(Array)
    end
  end

  describe ".debug" do
    it "stores the debug options" do
      described_class.debug :grid, :outlines
      described_class.debug_options.should == [:grid, :outlines]
    end
  end

  describe ".debug_options" do
    it "returns an array" do
      described_class.pages.should be_a(Array)
    end
  end

  let(:data){ {} }

  subject{ described_class.new(data) }

  describe "#data" do
    let(:data){ { woo: "yes"} }
    it "returns the data" do
      described_class.new(data).data.should == data
    end
  end

end
