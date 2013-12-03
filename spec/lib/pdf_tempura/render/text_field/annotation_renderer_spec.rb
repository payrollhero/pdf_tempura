require 'spec_helper'

describe PdfTempura::Render::TextField::AnnotationRenderer do

  let(:pdf) { Prawn::Document.new }
  let(:field) { PdfTempura::Document::TextField.new("foo", [0,0], [100,100]) }

  subject { described_class.new(field) }

  describe "#render" do
    example do
      subject.render(pdf)
    end
  end

end
