shared_example "a document field" do

  describe "method expectations" do
    it { should respond_to(:x) }
    it { should respond_to(:y) }
    it { should respond_to(:width) }
    it { should respond_to(:height) }
    it { should respond_to(:name) }
  end

end
