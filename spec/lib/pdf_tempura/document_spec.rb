require 'spec_helper'

describe PdfTempura::Document do

  let(:dummy_class) do
    Class.new(described_class)
  end

  describe "#new" do
    let(:data) do
      {
        100 => {
          first_name: "Stan",
          surname: "Smith",
          company: "CIA",
          address: "The Pentagon, Washington, DC"
        },
        200 => {
          emergency_contact: "Francine Smith",
          phone_number: "123-456-7890"
        }
      }
    end

    before :each do
      dummy_class.page(100){}
      dummy_class.page(200){}
    end

    it "loads the data into each correct page" do
      document = dummy_class.new(data)

      document.pages.first.data.should == {
        "first_name" => "Stan",
        "surname" => "Smith",
        "company" => "CIA",
        "address" => "The Pentagon, Washington, DC"
      }

      document.pages.last.data.should == {
        "emergency_contact" => "Francine Smith",
        "phone_number" => "123-456-7890"
      }
    end

    it "doesn't modify the class level pages" do
      dummy_class.new(data)
      dummy_class.pages.first.data.should == {}
      dummy_class.pages.last.data.should == {}
    end
  end

  describe ".template" do
    it "sets the template file path" do
      dummy_class.template "/some/path/to/template.pdf"
      dummy_class.template_file_path.should == "/some/path/to/template.pdf"
    end

    it "raises an argument error if you send it something that's not a string" do
      expect{
        dummy_class.template [123]
      }.to raise_error ArgumentError, "Template path must be a string."
    end
  end

  describe ".page" do
    let(:page){ PdfTempura::Document::Page.new(200) }

    it "yield a page object" do
      expect{ |block|
        dummy_class.page(200, &block)
      }.to yield_with_args(page)
    end

    it "passed method calls on to the new page object" do
      PdfTempura::Document::Page.any_instance.should_receive(:fields)

      dummy_class.page(200) do
        fields
      end
    end

    it "adds the page object to the pages list" do
      expect{
        dummy_class.page(200){}
      }.to change(dummy_class.pages, :count).by(1)
    end
  end

  describe ".pages" do
    it "returns an array" do
      dummy_class.pages.should be_a(Array)
    end
  end

  describe ".debug" do
    it "stores the debug options" do
      dummy_class.debug :grid, :outlines
      dummy_class.debug_options.should == [:grid, :outlines]
    end
  end

  describe ".debug_options" do
    it "returns an array" do
      dummy_class.pages.should be_a(Array)
    end
  end

end
