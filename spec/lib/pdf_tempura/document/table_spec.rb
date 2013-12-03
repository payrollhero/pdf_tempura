require 'spec_helper'
require_relative 'field_common'

describe PdfTempura::Document::Table do

  context "interface test" do
    subject { described_class.new("foo", [0,0], width: 100, number_of_rows: 10) }
    it_should_behave_like "a document field"
  end

  describe "init" do

    let(:name) { :table }
    let(:origin) { [0,0] }
    let(:options) { {} }

    describe "option validation" do
      shared_example "failing option test" do
        it "should complain" do
          expect {
            described_class.new(name, origin, options)
          }.to raise_exception(ArgumentError, "Two of height, number_of_rows or row_height have to be passed in options")
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
      let(:options) do
        {
          height: 100,
          number_of_rows: 10,
        }
      end

      example do
        expect {
          described_class.new(name, origin, options)
        }.not_to raise_exception
      end
    end

  end

  describe "#column"  do
  end

  describe "#spacer" do
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
