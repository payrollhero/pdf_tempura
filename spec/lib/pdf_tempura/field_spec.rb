require 'spec_helper'

describe PdfTempura::Field do

  let(:name){ :name }
  let(:coordinates){ [10, 20] }
  let(:dimensions){ [200, 100] }

  let(:options) do
    {
      type: type,
      default_value: default_value,
      font_size: font_size,
      bold: bold,
      alignment: alignment,
      multi_line: multi_line,
      padding: padding,
    }
  end

  let(:type){ "box-list" }
  let(:default_value){ "Bruce" }
  let(:font_size){ 13 }
  let(:bold){ true }
  let(:alignment){ :center }
  let(:multi_line){ true }
  let(:padding) { [1,2,3,4] }


  subject{ described_class.new(name, coordinates, dimensions, options) }

  its(:name){ should == "name" }
  its(:coordinates){ should == [10, 20] }
  its(:dimensions){ should == [200, 100] }
  its(:x){ should == 10 }
  its(:y){ should == 20 }
  its(:width){ should == 200 }
  its(:height){ should == 100 }
  its(:type){ should == "box-list" }
  its(:default_value){ should == "Bruce" }
  its(:font_size){ should == 13 }
  it{ should be_bold }
  its(:alignment){ should == "center" }
  it{ should be_multi_line }
  its(:padding) { should == [1,2,3,4] }

  describe "defaults" do
    subject{ described_class.new(name, coordinates, dimensions) }

    its(:type){ should == "text" }
    its(:default_value){ should nil }
    its(:font_size){ should == 10 }
    it{ should_not be_bold }
    its(:alignment){ should == "left" }
    its(:padding) { should == [0,0,0,0] }
    it{ should_not be_multi_line }
  end

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
        }.to raise_error ArgumentError, "Name must be a string or symbol."
      end
    end

    context "when passed invalid coordinates" do
      context "as an object other than Array" do
        let(:coordinates){ "1x1" }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must be an array containing two numbers, one for the x position and one for the y position."
        end
      end

      context "by passing an invalid x or y coordinate" do
        let(:coordinates){ ["a", "b" ] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must be an array containing two numbers, one for the x position and one for the y position."
        end
      end

      context "by passing not enough coordinates" do
        let(:coordinates){ [1] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must be an array containing two numbers, one for the x position and one for the y position."
        end
      end

      context "by passing too many coordinates" do
        let(:coordinates){ [1, 2, 3] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Coordinates must be an array containing two numbers, one for the x position and one for the y position."
        end
      end
    end

    context "when passed invalid dimensions" do
      context "as an object other than Array" do
        let(:dimensions){ "width200 height100" }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must be an array containing two numbers, one for the width and one for the height."
        end
      end

      context "by passing an invalid width or height" do
        let(:dimensions){ ["one hundred", "two_hundred" ]}

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must be an array containing two numbers, one for the width and one for the height."
        end
      end

      context "by passing not enough dimensions" do
        let(:dimensions){ [1] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must be an array containing two numbers, one for the width and one for the height."
        end
      end

      context "by passing too many dimensions" do
        let(:dimensions){ [1, 2, 3] }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Dimensions must be an array containing two numbers, one for the width and one for the height."
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

      context "as a hash with an unknown option" do
        before :each do
          options[:whatever] = "blah"
        end

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, dimensions, options)
          }.to raise_error ArgumentError, "Options hash contains an unknown option 'whatever'."
        end
      end

      context "as a hash with a bad value for" do
        context "type" do
          let(:type){ "super super" }

          it "throws an error" do
            expect{
              described_class.new(name, coordinates, dimensions, options)
            }.to raise_error ArgumentError, "Option 'type' must be either 'text', 'checkbox' or 'box-list'."
          end
        end

        context "default_value" do
          let(:default_value){ 3 }

          it "throws an error" do
            expect{
              described_class.new(name, coordinates, dimensions, options)
            }.to raise_error ArgumentError, "Option 'default_value' is not valid for the type 'box-list'."
          end
        end

        context "font_size" do
          let(:font_size){ "twenty" }

          it "throws an error" do
            expect{
              described_class.new(name, coordinates, dimensions, options)
            }.to raise_error ArgumentError, "Option 'font_size' must be a number."
          end
        end

        context "bold" do
          let(:bold){ 3 }

          it "throws an error" do
            expect{
              described_class.new(name, coordinates, dimensions, options)
            }.to raise_error ArgumentError, "Option 'bold' must be true or false."
          end
        end

        context "alignment" do
          let(:alignment){ :opposite }

          it "throws an error" do
            expect{
              described_class.new(name, coordinates, dimensions, options)
            }.to raise_error ArgumentError, "Option 'alignment' must be either 'left', 'right' or 'center'."
          end
        end

        context "multi_line" do
          let(:multi_line){ "x" }

          it "throws an error" do
            expect{
              described_class.new(name, coordinates, dimensions, options)
            }.to raise_error ArgumentError, "Option 'multi_line' must be true or false."
          end
        end

        context "padding" do
          context "as an object other than Array" do
            let(:padding){ "1,2,3,4" }

            it "throws an error" do
              expect{
                described_class.new(name, coordinates, dimensions, options)
              }.to raise_error ArgumentError, "Option 'padding' must be an array containing 4 numbers, the top, right, bottom, left padding values."
            end
          end
        end

      end
    end

  end

end
