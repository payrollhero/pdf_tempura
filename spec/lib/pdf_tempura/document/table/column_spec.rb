require 'spec_helper'

describe PdfTempura::Document::Table::Column do
  describe "init" do

    let(:name) { :col }
    let(:width) { 50 }
    let(:options) { {} }

    describe "option validation" do

      context "no type" do
        it "should complain" do
          expect {
              described_class.new(name, width, options)
            }.to raise_exception(ArgumentError)
        end
      end
      
      context "proper options" do
        let(:options) {{type: "text"}}
        it "should succeed" do
          expect {
            described_class.new(name, width, options)
          }.not_to raise_exception
        end
      end

    end
  end
end
