require 'spec_helper'

describe PdfTempura::Document::FieldSet do

  let(:group_name) { "group" }
  subject{ described_class.new(group_name) }
  it_behaves_like "a field that accepts default commands"

  describe "#new" do
    it "should have no fields" do
      subject = described_class.new(group_name)
      subject.fields.should be_empty
    end

    it "should yield" do

    end
  end

  describe "coordinate calculation" do
    it "calculates correct coordinates with one and two text fields" do
      subject.text_field :name,[5,30],[20,20]
      subject.width.should == 20
      subject.x.should == 5
      subject.y.should == 30
      subject.height.should == 20

      subject.text_field :bar,[0,30], [50,10]
      subject.width.should == 50
      subject.height.should == 20
      subject.x.should == 0
      subject.y.should == 30
    end
  end

end
