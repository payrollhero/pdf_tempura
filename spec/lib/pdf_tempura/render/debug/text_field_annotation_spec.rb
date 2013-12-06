require 'spec_helper'

describe PdfTempura::Render::Debug::TextFieldAnnotation do

  let(:pdf) { Prawn::Document.new }
  let(:field) { PdfTempura::Document::TextField.new("foo", [0,0], [100,100]) }

  let(:field_options) do
    {
      at: [1, 99],
      width: 98,
      height: 98,
      valign: :top,
      single_line: true
    }
  end

  let(:label_options) do
    {
      at: [1, 99],
      width: 98,
      height: 98,
      valign: :bottom,
      align: :right,
      single_line: true
    }
  end

  subject { described_class.new(field) }

  describe "#render" do
    example do
      expect{
        subject.render(pdf)
      }.to_not raise_error
    end

    example do
      pdf.should_receive(:text_box).once.with("x: 0 y: 0 w: 100 h: 100", field_options)
      pdf.should_receive(:text_box).once.with("foo", label_options)
      subject.render(pdf)
    end
  end

end

