require 'spec_helper'

describe PdfTempura::Render::BoxedCharacters do

  let(:field_options) {{box_width: 10, box_spacing: 2}}
  let(:field) {
    PdfTempura::Document::BoxedCharacters.new(:pin,[0,0],20,field_options) do
      characters 2
      space 2
      characters 8
      space 2
      characters 2
    end
  }
  let(:data) { "228888888822" }
  let(:pdf) { Prawn::Document.new }
  let(:options) { {} }

  describe "init" do
    example do

      expect {
        described_class.new(field, data, options)
      }.not_to raise_exception
    end
  end

  describe "render" do

    context "with appropriate data" do
      it "renders each field with the appropriate data" do
        expect {
          described_class.new(field,data,options).render(pdf)
        }.not_to raise_exception
      end
    end

    context "with nil data" do
      let(:data) {nil}
      it "assumes an empty string and still renders without error" do
        expect {
          described_class.new(field,data,options).render(pdf)
        }.not_to raise_exception
      end
    end

    context "with inappropriate data" do
      let(:data) {"123456789101112"}
      it "throws an argument error if truncate not specified" do
        expect {
          described_class.new(field,data,options).render(pdf)
        }.to raise_error ArgumentError, "Data for pin must be exactly 12 characters or use the truncate option."
      end

      context "when truncate is specified" do
        let(:field_options) {{box_width: 10, box_spacing: 2, truncate: true}}
        it "renders without error" do
          expect {
            described_class.new(field,data,options).render(pdf)
          }.not_to raise_exception
        end
      end

    end
  end

end

