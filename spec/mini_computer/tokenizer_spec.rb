require_relative "../../lib/mini_computer/tokenizer"

RSpec.describe Tokenizer do
  describe ".tokens" do
    it "returns the array of tokens" do
      actual = described_class.tokens("1+2*3")
      expect(actual).to eq [1, :+, 2, :*, 3]
    end
  end
end
