require 'spec_helper'
require_relative 'field_common'

describe PdfTempura::Document::Table do

  context "interface test" do
    subject { described_class.new("foo", [0,0], height: 100, number_of_rows: 10) }
    it_should_behave_like "a document field"
  end

  describe "init" do

    let(:name) { :table }
    let(:origin) { [0,0] }
    let(:options) { {} }
    let(:valid_options) { {height: 100, row_height: 10, number_of_rows: 10}}

    describe "option validation" do
      shared_examples "failing option test" do
        it "should complain" do
          expect {
            described_class.new(name, origin, options)
          }.to raise_exception(ArgumentError, "You must pass number_of_rows and either height or row_height")
        end
      end

      context "only number_of_rows is passed" do
        let(:options) { {:number_of_rows => 10} }
        it_should_behave_like "failing option test"
      end

      context "only height is passed" do
        let(:options) { {:height => 100} }
        it_should_behave_like "failing option test"
      end

      context "only row_height is passed" do
        let(:options) { {:row_height => 10} }
        it_should_behave_like "failing option test"
      end

    end

    context "valid options" do
      shared_examples "passing options" do
        it "should not complain" do
          expect {
          described_class.new(name, origin, options)
        }.not_to raise_exception
        end
        it "should be 100 tall with 10 row_height" do
          subject =  described_class.new(name,origin,options)
          subject.height.should == 100
          subject.row_height.should == 10
        end
      end
      
      context "height and number of rows" do
        let(:options) {{ height: 100, number_of_rows: 10}}
        it_should_behave_like "passing options"
      end
      
      context "row_height and number of rows" do
        let(:options) {{ row_height: 10, number_of_rows: 10}}
        it_should_behave_like "passing options"
      end
    end

    
    describe "yielding" do
      it "should yield" do
        expect { |b| described_class.new(name,origin,valid_options,&b)}.to yield_control
      end
    end
  end

  describe "#column"  do
    let(:options) { {height: 100, number_of_rows: 10} }
    let(:subject) { described_class.new(:table,[0,0],options)}
    
    it "should add a column to the table" do
      subject.column(:pin, 50, type: "text")
      subject.columns.count.should == 1
      subject.columns.first.name.should == :pin
    end
  end

  describe "#spacer" do
    let(:options) { {height: 100, number_of_rows: 10} }
    let(:subject) { described_class.new(:table,[0,0],options)}
    
    it "should add a spacer to the table" do
      subject.spacer(5)
      subject.columns.count.should == 1
      subject.columns.first.type.should == "spacer"
    end
  end
  
  describe "#cells" do
  end

  describe "#name" do
  end

  describe "#x" do
  end

  describe "#y" do
  end

  describe "#width" do
  end

  describe "#height" do
  end

end
