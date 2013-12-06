require 'spec_helper'

describe PdfTempura::Render::Debug::Annotation::Base do

  let(:pdf) { Prawn::Document.new }
  let(:field) { PdfTempura::Document::TextField.new("foo", [0,0], [100,100]) }

  subject { described_class.new(field) }

  describe "#render" do
    context "if field_options is not defined" do
      example do
        expect{
          subject.render(pdf)
        }.to raise_error NotImplementedError, "Implement field_options in your subclass."
      end
    end

    context "if label_options is not defined" do
      before :each do
        subject.stub(:field_options){ {} }
      end

      example do
        expect{
          subject.render(pdf)
        }.to raise_error NotImplementedError, "Implement label_options in your subclass."
      end
    end

    context "if both are defined" do
      before :each do
        subject.stub(:field_options){ {} }
        subject.stub(:label_options){ {} }
      end

      example do
        expect{
          subject.render(pdf)
        }.to_not raise_error
      end
    end
  end

end
