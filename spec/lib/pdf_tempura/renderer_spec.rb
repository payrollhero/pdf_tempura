require 'spec_helper'

describe PdfTempura::Renderer do

  let(:pages) { [double("page")] }
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

  end

end
