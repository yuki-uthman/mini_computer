require_relative "../../lib/mini_computer/operator"

RSpec.describe "Operator class" do
  describe ".compare" do
    context "when left op has stronger precedence" do
      it "returns 1" do
        actual = Operator.compare(:*, :+)
        expect(actual).to eq 1
      end
    end

    context "when left op has weaker precedence" do
      it "returns -1" do
        actual = Operator.compare(:+, :*)
        expect(actual).to eq(-1)
      end
    end

    context "when equal precedence" do
      it "returns 0" do
        actual = Operator.compare(:+, :-)
        expect(actual).to eq(0)
      end
    end

    context "when right op is nil" do
      it "always returns 1" do
        actual = Operator.compare(:+, nil)
        expect(actual).to eq 1

        actual = Operator.compare(:*, nil)
        expect(actual).to eq 1
      end
    end

    context "when left op is nil" do
      it "always returns -1" do
        actual = Operator.compare(nil, :+)
        expect(actual).to eq(-1)

        actual = Operator.compare(nil, :*)
        expect(actual).to eq(-1)
      end
    end
  end
end
