require_relative "../../lib/mini_computer/operator"

RSpec.describe Operator do
  describe ".compare" do
    context "when left op has stronger precedence" do
      it "returns 1" do
        actual = described_class.compare(:*, :+)
        expect(actual).to eq 1
      end
    end

    context "when left op has weaker precedence" do
      it "returns -1" do
        actual = described_class.compare(:+, :*)
        expect(actual).to eq(-1)
      end
    end

    context "when equal precedence" do
      it "returns 0" do
        actual = described_class.compare(:+, :-)
        expect(actual).to eq(0)
      end
    end

    context "with + and nil" do
      it "returns 1" do
        actual = described_class.compare(:+, nil)
        expect(actual).to eq 1
      end
    end

    context "with * and nil" do
      it "returns 1" do
        actual = described_class.compare(:*, nil)
        expect(actual).to eq 1
      end
    end

    context "with nil and :+" do
      it "returns -1" do
        actual = described_class.compare(nil, :+)
        expect(actual).to eq(-1)
      end
    end

    context "with nil and :*" do
      it "returns -1" do
        actual = described_class.compare(nil, :*)
        expect(actual).to eq(-1)
      end
    end
  end
end
