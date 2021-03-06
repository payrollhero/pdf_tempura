require 'spec_helper'

describe PdfTempura::Render::TextField do

  let(:field) { PdfTempura::Document::TextField.new("foo", [0,0], [100,100]) }
  let(:options) { {} }
  let(:pdf) { Prawn::Document.new }

  describe "initialize" do
    example do
      expect {
        described_class.new(field, "foo", options)
      }.not_to raise_exception
    end
  end

  describe "#render" do

    subject { described_class.new(field, "foo", options) }

    describe "calling the annotation drawing code when enabled" do
      let(:options) do
        {
          :debug => [:outlines]
        }
      end

      let(:annotation_renderer) { double(:annotation_renderer) }

      example do
        PdfTempura::Render::Debug::TextFieldAnnotation.should_receive(:new).with(field).and_return(annotation_renderer)
        annotation_renderer.should_receive(:render).with(pdf)
        subject.render(pdf)
      end
    end

  end

end
