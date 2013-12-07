require 'spec_helper'

describe PdfTempura::Document::BoxedCharacters do

  context "valid options" do
    let(:options) {{box_width: 10, box_spacing: 1}}
    let(:height){ 100 }
    subject{ described_class.new(name, coordinates, height,options) { characters 20} }
    it_behaves_like "a document field"
  end
  
  let(:options) {{box_width: 10, box_spacing: 1}}
  let(:name){ :text_field }
  let(:coordinates){ [0, 0] }
  let(:height){ 10 }
  
  describe ".characters" do
    let(:subject) {described_class.new(name, coordinates, height, options)}
    
    context "when passed valid number of characters" do
      it "adds supported characters" do
        subject.characters 5
        subject.supported_characters.should == 5
        subject.characters 2
        subject.supported_characters.should == 7
      end
    end
    
    context "when passed invalid number of characters" do
      it "fails to add characters" do
       expect{
            subject.characters "a"
       }.to raise_error ArgumentError, "Characters must be of type Numeric." 
      end
    end
  end
  
  describe ".space" do
    let(:subject) {described_class.new(name, coordinates, height, options)}
    
    context "when passed a valid length" do
      it "adds space groups" do
        subject.space 2
        subject.groups.count.should == 1
        subject.supported_characters.should == 0
        subject.space 3
        subject.groups.count.should == 2
        subject.supported_characters.should == 0
      end
    end
    
    context "when passed an invalid length" do
      it "fails with an error" do
         expect{
            subject.space "a"
       }.to raise_error ArgumentError, "Spacing must be of type Numeric."
      end
    end
  end
  
  describe ".fields" do
    let(:options) {{box_width: 10, box_spacing: 1}}
    let(:subject) do 
      described_class.new(name,coordinates,height,options) do
        characters 2
        space 2
        characters 2
      end
    end
    
    it "returns correct number of fields at correct coordinates" do
      PdfTempura::Document::CharacterField.tap do |it|
        it.should_receive(:new).with(name.to_s, [0,0],[10,10], {}).and_call_original
        it.should_receive(:new).with(name.to_s, [11,0],[10,10], {}).and_call_original
        it.should_receive(:new).with(name.to_s, [23,0],[10,10], {}).and_call_original
        it.should_receive(:new).with(name.to_s, [34,0],[10,10], {}).and_call_original
      end
      subject.fields.count.should == 4
    end
  end

  describe "validation" do
    context "when passed valid attributes" do
      it "returns a field object" do
        described_class.new(name, coordinates, height, options).should be_a(described_class)
      end
      it "should yield" do
        expect { |b| described_class.new(name, coordinates, height, options,&b)}.to yield_control
      end
    end

    context "when passed invalid options" do
      context "without required options" do
        let(:options){ {} }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, height, options)
          }.to raise_error ArgumentError, "Box_width is required."
        end
      end

      context "with box spacing and width not numeric" do
        let(:options){ {box_width: "foo",box_spacing: "bar"} }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, height, options)
          }.to raise_error ArgumentError, "Box_width must be of type Numeric."
        end
      end
      
      context "with bad truncate option" do
        let(:options){ {box_width: 1,box_spacing: 2, truncate: "foo"} }

        it "throws an error" do
          expect{
            described_class.new(name, coordinates, height, options)
          }.to raise_error ArgumentError, "Truncate must be of type boolean."
        end
      end
    end
  end

end
