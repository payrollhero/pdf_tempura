require 'spec_helper'

shared_examples_for "a document field" do
  let(:name){ :name }
  let(:coordinates){ [10, 20] }
  let(:dimensions){ [200, 100] }

  its(:name){ should == "name" }
  its(:coordinates){ should == [10, 20] }
  its(:dimensions){ should == [200, 100] }
  its(:x){ should == 10 }
  its(:y){ should == 20 }
  its(:width){ should == 200 }
  its(:height){ should == 100 }

end


shared_examples_for "a document field with a standard constructor" do
  let(:name){ :name }
  let(:coordinates){ [10, 20] }
  let(:dimensions){ [200, 100] }

  describe "validation" do
    context "when passed valid attributes" do
      it "returns a field object" do
        described_class.new(name, coordinates, dimensions, options).should be_a(described_class)
      end
    end

    context "when passed an invalid name" do
      let(:name){ [] }

      it "throws an error" do
        expect{
          described_class.new(name, coordinates, dimensions, options)
        }.to raise_error ArgumentError, "Name must be of type String."
      end
    end

    context "when passed invalid coordinates" do
      context "as an object other than Array" do
        let(:coordinates){ "1x1" }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must be of type Array."
        end
      end

      context "by passing an invalid x or y coordinate" do
        let(:coordinates){ ["a", "b" ] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must contain only Numeric values."
        end
      end

      context "by passing not enough coordinates" do
        let(:coordinates){ [1] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must contain 2 values."
        end
      end

      context "by passing too many coordinates" do
        let(:coordinates){ [1, 2, 3] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must contain 2 values."
        end
      end
    end

    context "when passed invalid dimensions" do
      context "as an object other than Array" do
        let(:dimensions){ "width200 height100" }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must be of type Array."
        end
      end

      context "by passing an invalid width or height" do
        let(:dimensions){ ["one hundred", "two_hundred" ]}

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must contain only Numeric values."
        end
      end

      context "by passing not enough dimensions" do
        let(:dimensions){ [1] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must contain 2 values."
        end
      end

      context "by passing too many dimensions" do
        let(:dimensions){ [1, 2, 3] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must contain 2 values."
        end
      end

    end

    context "when passed invalid options" do
      context "as an object other than a hash" do
        let(:options){ "these are bogus options" }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Options must be a hash."
        end
      end
    end
  end

end

shared_examples "a field that accepts default commands" do
  describe ".table" do

    it "adds a table field to the field list" do
      subject.fields.should == []
      subject.table(:foo, [0,0], height: 100, number_of_rows: 10) { }
      subject.fields.first.should be_a(PdfTempura::Document::Table)
    end

    it "yields" do
      expect { |b|
        subject.table(:foo, [0,0], height: 100, number_of_rows: 10, &b)
      }.to yield_control
    end

  end

  describe ".text_field" do
    let(:name){ :text_field }
    let(:coordinates){ [10, 20] }
    let(:dimensions){ [200, 100] }

    context "when not passed a type" do
      it "adds a field object given valid attributes" do
        expect{
          subject.text_field(name, coordinates, dimensions)
        }.to change(subject.fields, :count).by (1)
      end

      it "creates the correct field object" do
        subject.text_field(name, coordinates, dimensions)
        field = subject.fields.first
        field.should be_a(PdfTempura::Document::TextField)
        field.name.should == "text_field"
        field.coordinates.should == [10, 20]
        field.dimensions.should == [200, 100]
      end
    end
  end

  describe ".boxed_characters" do
    let(:name){ :pin_code}
    let(:height) {20}
    let(:coordinates) {[50,20]}
    let(:options) {{box_spacing: 1, box_width: 10}}

    context "when passed appropriate parameters" do
      it "adds a field to the subject" do
        expect{
          subject.boxed_characters(name, coordinates, height, options) do
            characters 4
          end
        }.to change(subject.fields, :count).by (1)
      end
    end
  end

  describe ".field_set" do
    let(:name) { :group }

    context "when called" do
      it "adds a field" do
        expect {
          subject.field_set "group"
        }.to change(subject.fields,:count).by (1)
      end
    end
  end

  describe ".checkbox_field" do
    let(:name){ :checkbox_field}
    let(:coordinates){ [10, 20] }
    let(:dimensions){ [20, 20] }

    context "when not passed a type" do
      it "adds a field object given valid attributes" do
        expect{
          subject.checkbox_field(name, coordinates, dimensions)
        }.to change(subject.fields, :count).by (1)
      end

      it "creates the correct field object" do
        subject.checkbox_field(name, coordinates, dimensions)
        field = subject.fields.first
        field.should be_a(PdfTempura::Document::CheckboxField)
        field.name.should == "checkbox_field"
        field.coordinates.should == [10, 20]
        field.dimensions.should == [20, 20]
      end
    end
  end
end
