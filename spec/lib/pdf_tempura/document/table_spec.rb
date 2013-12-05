require 'spec_helper'
require_relative 'field_common'

describe PdfTempura::Document::Table do

  context "interface test" do
    subject { described_class.new("foo", [0,0], height: 100, number_of_rows: 10) }
    it_should_behave_like "a document field methods"
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

  describe "#text_column"  do
    let(:options) { {height: 100, number_of_rows: 10} }
    let(:subject) { described_class.new(:table,[0,0],options)}
    
    it "should add a column to the table" do
      subject.text_column(:pin, 50)
      subject.columns.count.should == 1
      subject.columns.first.should be_kind_of(PdfTempura::Document::Table::TextColumn)
    end
  end
  
  describe "#checkbox_column"  do
    let(:options) { {height: 100, number_of_rows: 10} }
    let(:subject) { described_class.new(:table,[0,0],options)}
    
    it "should add a column to the table" do
      subject.checkbox_column(:pin, 50)
      subject.columns.count.should == 1
      subject.columns.first.should be_kind_of(PdfTempura::Document::Table::CheckboxColumn)
    end
  end

  describe "#spacer" do
    let(:options) { {height: 100, number_of_rows: 10} }
    let(:subject) { described_class.new(:table,[0,0],options)}
    
    it "should add a spacer to the table" do
      subject.spacer(5)
      subject.columns.count.should == 1
      subject.columns.first.should be_kind_of(PdfTempura::Document::Table::Spacer)
    end
  end

  describe "#width" do
    subject { described_class.new(:table,[0,0],options) }
    
    context "no padding" do
      let(:options) { {height: 100, number_of_rows: 10} }
      
      it "calculates width correctly" do
        subject.text_column :a,10
        subject.width.should == 10
        subject.text_column :b,15
        subject.width.should == 25
        subject.spacer 5
        subject.width.should == 30
      end
    end
    
    context "with padding" do
      let(:options) { {height: 100, number_of_rows: 10, cell_padding: 2} }
      
      it "calculates width correctly" do
        subject.text_column :a,10
        subject.width.should == 10
        subject.text_column :b,15
        subject.width.should == 27
        subject.spacer 5
        subject.width.should == 34
      end
      
    end
  end
end
    
