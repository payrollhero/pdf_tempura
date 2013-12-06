require 'spec_helper'

describe PdfTempura::Render::Debug::Grid do

  let(:pdf) { Prawn::Document.new }

  describe "render" do

    it "takes a pdf document as a param" do
      subject.render(pdf)
    end

  end

end
