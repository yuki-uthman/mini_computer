require_relative "../../lib/mini_computer/stack"

RSpec.describe Stack do
  let(:empty_stack) { described_class.new }
  let(:numbers_stack) { described_class.new with: [1, 2, 3] }
  let(:reg_stack) { described_class.new header: "Reg" }

  describe "#initialize" do
    context "when no header is given" do
      it "default header is \"Stack\"" do
        expect(empty_stack.header).to eq "Stack"
      end
    end

    context "when header is given" do
      it "returns the header" do
        expect(reg_stack.header).to eq "Reg"
      end
    end

    context "when initial data is given" do
      it "stores the data on the stack" do
        expect(numbers_stack).to eq [1, 2, 3]
      end
    end
  end

  describe "#push" do
    context "when pushed once" do
      it "pushes it onto the stack" do
        empty_stack.push 1
        expect(empty_stack).to eq([1])
      end
    end

    context "when pushed twice" do
      it "pushes second value after the first" do
        empty_stack.push 1
        empty_stack.push 2
        expect(empty_stack).to eq([1, 2])
      end
    end
  end

  describe "#pop" do
    context "when it is not empty" do
      it "removes the last element from the stack" do
        numbers_stack.pop
        expect(numbers_stack).to eq([1, 2])
      end

      it "returns the popped element" do
        empty_stack.push 1
        expect(empty_stack.pop).to eq 1
      end
    end

    context "when empty" do
      it "raises StackEmptyError" do
        expect { empty_stack.pop }.to raise_error(StackEmptyError)
      end
    end
  end

  describe "#set=" do
    it "replaces the stack to the new one" do
      numbers_stack.set = [7, 8, 9]
      expect(numbers_stack).to eq [7, 8, 9]
    end
  end

  describe "#peek" do
    context "when it is not empty" do
      it "returns the value without popping the value" do
        empty_stack.push 1
        empty_stack.peek
        expect(empty_stack).to eq [1]
      end
    end

    context "when empty" do
      it "returns nil" do
        numbers_stack.clear
        expect(numbers_stack.peek).to eq nil
      end
    end
  end

  describe "#size" do
    context "when not empty" do
      it "returns the size of the stack" do
        expect(numbers_stack.size).to eq(3)
      end
    end

    context "when empty" do
      it "returns 0" do
        numbers_stack.clear
        expect(numbers_stack.size).to eq 0
      end
    end
  end

  describe "#empty?" do
    context "when not empty" do
      it "returns false" do
        expect(numbers_stack.empty?).to eq false
      end
    end

    context "when empty" do
      it "returns true" do
        expect(empty_stack.empty?).to eq true
      end
    end
  end

  describe "#view" do
    context "with default stack header" do
      it "prints the table header with Stack" do
        expected = <<~OUTPUT
          ┌───────┐
          │ Stack │
          ├───────┤
          │   3   │
          │   2   │
          │   1   │
          └───────┘
        OUTPUT
        expect { numbers_stack.view }.to output(expected).to_stdout
      end
    end

    context "with custom stack header" do
      it "print the table header with custom stack header" do
        reg_stack.set = [1, 2, 3]
        expected = <<~OUTPUT
          ┌─────┐
          │ Reg │
          ├─────┤
          │  3  │
          │  2  │
          │  1  │
          └─────┘
        OUTPUT
        expect { reg_stack.view }.to output(expected).to_stdout
      end
    end
  end
end
