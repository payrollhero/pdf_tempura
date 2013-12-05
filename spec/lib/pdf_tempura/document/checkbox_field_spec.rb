require 'spec_helper'

describe PdfTempura::Document::CheckboxField do

  it_behaves_like "a document field"

  let(:name){ :checkbox_field }
  let(:coordinates){ [10, 20] }
  let(:dimensions){ [10, 10] }
  let(:default_value){ true }
  let(:padding){ [1,1,1,1]}
  let(:options){ { default_value: default_value, padding: padding} }

  subject{ described_class.new(name, coordinates, dimensions, options) }

  its(:default_value){ should be_true }

  describe "defaults" do
    subject{ described_class.new(name, coordinates, dimensions) }

    its(:default_value){ should be_false }
  end

  describe "validation" do
    context "when passed valid attributes" do
      it "returns a field object" do
        described_class.new(name, coordinates, dimensions, options).should be_a(described_class)
      end
    end

    context "when passed invalid options" do
      context "default_value" do
        let(:default_value){ 3 }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Default_value must be one of the following values: true, false."
        end
      end
      
      context "padding" do
        let(:padding){[3,2,1]}
        
        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Padding must contain 4 values."
        end
      end
    end
  end

end
