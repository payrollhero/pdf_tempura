require 'spec_helper'

describe PdfTempura::Extensions::Hash::StringifyKeys do

  subject do
    {
      foo: true,
      bar: {
        blah: "abc"
      },
      woo: [
        1,
        {
          blorgh: false
        }
      ]
    }.extend(described_class)
  end

  describe "#stringify_keys" do
    example do
      result = subject.stringify_keys
      result["foo"].should be_true
      result["bar"].should == { "blah" => "abc" }
      result["woo"].should == [1, { "blorgh" => false }]

      subject["foo"].should be_nil
      subject["bar"].should be_nil
      subject["woo"].should be_nil
    end
  end

  describe "#stringify_keys!" do
    example do
      subject.stringify_keys!
      subject["foo"].should be_true
      subject["bar"].should == { "blah" => "abc" }
      subject["woo"].should == [1, { "blorgh" => false }]
    end
  end

end
