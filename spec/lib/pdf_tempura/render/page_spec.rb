require 'spec_helper'

describe PdfTempura::Render::Page do

  let(:page) { PdfTempura::Document::Page.new(1) }
  let(:data) { { } }
  let(:pdf) { Prawn::Document.new }
  let(:options) { {} }

  before do
    page.data = data

    pdf.stub(:bounding_box) do |&block|
      block.call
    end
  end

  describe "init" do
    example do
      expect {
        described_class.new(page, options)
      }.not_to raise_exception
    end
  end

  describe "render" do

    subject do
      described_class.new(page, options)
    end

    let(:page) do
      page = PdfTempura::Document::Page.new(1)
      page.text_field "one", [0,0], [0,0]
      page.text_field "two", [0,0], [0,0]
      page
    end

    let(:data) do
      {
        "one" => "foo",
        "two" => "bar",
      }
    end

    let(:text_field_1) { double(:text_field_1) }
    let(:text_field_2) { double(:text_field_2) }

    it "calls renders each field" do
      PdfTempura::Render::TextField.tap do |it|
        it.should_receive(:new).with(page.fields[0], "foo", options).and_return(text_field_1)
        it.should_receive(:new).with(page.fields[1], "bar", options).and_return(text_field_2)
      end
      text_field_1.should_receive(:render).with(pdf)
      text_field_2.should_receive(:render).with(pdf)
      subject.render(pdf)
    end

    describe "calling the grid drawing code when enabled" do
      let(:options) do
        {
          :debug => [:grid]
        }
      end

      let(:grid_renderer) { double(:grid_renderer) }

      example do
        PdfTempura::Render::Debug::Grid.should_receive(:new).and_return(grid_renderer)
        grid_renderer.should_receive(:render).with(pdf)
        subject.render(pdf)
      end
    end

  end

end
