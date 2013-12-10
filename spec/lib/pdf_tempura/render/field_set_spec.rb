require 'spec_helper'

describe PdfTempura::Render::FieldSet do

  let(:group) {
    PdfTempura::Document::FieldSet.new("group") do
      text_field :a, [0,0], [10,10]
      text_field :b, [10,0], [10,10]
    end
  }
  let(:data) { {"a" => "1","b" => "2"} }
  let(:pdf) { Prawn::Document.new }
  let(:options) { {} }

  describe "init" do
    example do
      expect {
        described_class.new(group,data)
      }.not_to raise_exception
    end
  end

  describe "render" do

    let(:text_field_1){double(:text_field_1)}
    let(:text_field_2){double(:text_field_2)}

    it "renders each field with the appropriate data" do
      PdfTempura::Render::Field.tap do |it|
        it.should_receive(:generate).with(kind_of(PdfTempura::Document::TextField),"1",{}).and_return(text_field_1)
        it.should_receive(:generate).with(kind_of(PdfTempura::Document::TextField),"2",{}).and_return(text_field_2)
      end
      text_field_1.should_receive(:render).with(pdf)
      text_field_2.should_receive(:render).with(pdf)
      described_class.new(group,data).render(pdf)
    end
  end

end


