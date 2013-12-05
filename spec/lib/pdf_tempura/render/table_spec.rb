require 'spec_helper'

describe PdfTempura::Render::Table do

  let(:doc_table) { 
    PdfTempura::Document::Table.new(:table,[0,100],:number_of_rows => 10, :height => 100) do
      text_column :a, 10
      spacer 10
      text_column :b, 10
    end
  }
  let(:data) { [{:a => "1",:b => "2"},{:a => "3",:b => "4"}] }
  let(:pdf) { Prawn::Document.new }
  let(:options) { {} }

  describe "init" do
    example do
      expect {
        described_class.new(doc_table, data, options)
      }.not_to raise_exception
    end
  end
  
  describe "render" do

    it "renders each field with the appropriate data" do
      PdfTempura::Document::TextField.tap do |it|
        it.should_receive(:new).with(:a, [0,100],[10,10], options).and_call_original
        it.should_receive(:new).with(:b, [20,100],[10,10], options).and_call_original
        it.should_receive(:new).with(:a, [0,90],[10,10], options).and_call_original
        it.should_receive(:new).with(:b, [20,90],[10,10], options).and_call_original
      end
      described_class.new(doc_table,data,options).render(pdf)
    end
  end

end

