shared_examples "a document field methods" do

  describe "method expectations" do
    it { should respond_to(:x) }
    it { should respond_to(:y) }
    it { should respond_to(:width) }
    it { should respond_to(:height) }
    it { should respond_to(:name) }
    it { should respond_to(:padding) }
  end

end
