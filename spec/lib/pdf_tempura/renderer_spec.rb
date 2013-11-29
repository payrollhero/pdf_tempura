require 'spec_helper'

describe PdfTempura::Renderer do

  let(:pages) do
    [
      PdfTempura::Page.new(1)
    ]
  end
  let(:data) { { 1 => {} } }
  let(:options) { { debug: [] } }

  describe "initialize" do
    example do
      expect {
        described_class.new(sample_pdf_path, pages, data, options)
      }.not_to raise_exception
    end
  end

  describe "#render" do
    subject do
      described_class.new(sample_pdf_path, pages, data, options)
    end

    it "yields" do
      expect { |x|
        subject.render(&x)
      }.to yield_control
    end

    it "yields an object that responds to read" do
      subject.render do |file|
        expect(file).to respond_to(:read)
      end
    end

    it "yields a file with a pdf in it" do
      subject.render do |file|
        tempfile = Tempfile.new("spec")
        begin
          tempfile.write file.read
          tempfile.flush
          expect(`file -b --mime-type #{tempfile.path.inspect}`.strip).to eq("application/pdf")
        ensure
          tempfile.unlink
        end
      end
    end

    describe do
      let(:pages) do
        [
          double(:page1, number: 1),
          double(:page2, number: 2),
        ]
      end
      let(:data) do
        {
          1 => {
            "one" => "1",
          },
          2 => {
            "two" => "2",
          },
        }
      end

      let(:render_page_1) { double(:render_page_1) }
      let(:render_page_2) { double(:render_page_2) }

      # bit of an implementation test, but can't see a better way to do it right now
      it "calls render on each page" do
        PdfTempura::Render::Page.should_receive(:new).with(pages[0], data[1]).and_return(render_page_1)
        PdfTempura::Render::Page.should_receive(:new).with(pages[1], data[2]).and_return(render_page_2)
        render_page_1.should_receive(:render)
        render_page_2.should_receive(:render)
        subject.render do |file|; end
      end

    end

  end

end
