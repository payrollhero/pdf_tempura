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
    let(:text_field_1) { double(:text_field_1)}
    let(:text_field_2) { double(:text_field_2)}
    let(:text_field_3) { double(:text_field_3)}
    let(:text_field_4) { double(:text_field_4)}
    
    let(:render_field_1) { double(:render_field_1)}
    let(:render_field_2) { double(:render_field_2)}
    let(:render_field_3) { double(:render_field_3)}
    let(:render_field_4) { double(:render_field_4)}
    
    it "renders each field with the appropriate data" do
      PdfTempura::Document::TextField.tap do |it|
        it.should_receive(:new).with(:a, [0,100],[10,10], options).and_return(text_field_1)
        it.should_receive(:new).with(:b, [20,100],[10,10], options).and_return(text_field_2)
        it.should_receive(:new).with(:a, [0,90],[10,10], options).and_return(text_field_3)
        it.should_receive(:new).with(:b, [20,90],[10,10], options).and_return(text_field_4)
      end
      PdfTempura::Render::TextField.tap do |it|
        it.should_receive(:new).with(text_field_1,"1", options).and_return(render_field_1)
        it.should_receive(:new).with(text_field_2,"2", options).and_return(render_field_2)
        it.should_receive(:new).with(text_field_3,"3", options).and_return(render_field_3)
        it.should_receive(:new).with(text_field_4,"4", options).and_return(render_field_4)
      end
      render_field_1.should_receive(:render).with(pdf)
      render_field_2.should_receive(:render).with(pdf)
      render_field_3.should_receive(:render).with(pdf)
      render_field_4.should_receive(:render).with(pdf)
      described_class.new(doc_table,data,options).render(pdf)
    end
  end

end

