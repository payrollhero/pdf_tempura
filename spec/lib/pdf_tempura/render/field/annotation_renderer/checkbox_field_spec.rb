require 'spec_helper'

describe PdfTempura::Render::Field::AnnotationRenderer::CheckboxField do

  let(:pdf) { Prawn::Document.new }
  let(:field) { PdfTempura::Document::CheckboxField.new("foo", [0,0], [100,100]) }

  let(:field_options) do
    {
      at: [1, 116],
      width: 400,
      height: 98,
      valign: :top
    }
  end

  let(:label_options) do
    {
      at: [1, 91],
      width: 200,
      height: 98,
      valign: :bottom,
      align: :left,
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

