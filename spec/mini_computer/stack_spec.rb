require_relative "../../lib/mini_computer/stack"

RSpec.describe "Stack class" do
  before do
    @stack = Stack.new
  end

  describe "#push" do
    context "given 1" do
      it "pushes 1 onto the stack" do
        @stack.push 1
        expect(@stack).to eq([1])
      end
    end

    context "given 1 and then 2" do
      it "pushes 1 and 2 onto the stack" do
        @stack.push 1
        @stack.push 2
        expect(@stack).to eq([1, 2])
      end
    end
  end

  describe "pop" do
    context "when it is not empty" do
      it "removes the last element from the stack" do
        @stack.push 1
        expect(@stack).to eq([1])
        @stack.pop
        expect(@stack).to eq([])
      end

      it "returns the popped element" do
        (1..5).each do |i|
          @stack.push i
        end
        5.downto(1) do |i|
          expect(@stack.pop).to eq(i)
        end
      end

      it "raises StackEmptyError when empty" do
        expect { @stack.pop }.to raise_error(StackEmptyError)
      end
    end
  end

  describe "#size" do
    context "when not empty" do
      it "returns the size of the stack" do
        @stack.push 1
        @stack.push 2
        @stack.push 3

        expect(@stack.size).to eq(3)
      end

      context "when empty" do
        it "returns 0" do
          expect(@stack.size).to eq 0
        end
      end
    end
  end

  describe "#empty?" do
    context "when not empty" do
      it "returns false" do
        @stack.push 1
        expect(@stack.empty?).to eq false
      end
    end

    context "when empty" do
      it "returns true" do
        expect(@stack.empty?).to eq true
      end
    end
  end

  describe "#view" do
    context "when not empty" do
      it "prints the values on the stack" do
        @stack.push 1
        @stack.push 2
        @stack.push 3
        expected = <<~OUTPUT
          ┌───────┐
          │ Stack │
          ├───────┤
          │   3   │
          │   2   │
          │   1   │
          └───────┘
        OUTPUT
        expect { @stack.view }.to output(expected).to_stdout

        @stack.pop
        expected = <<~OUTPUT
          ┌───────┐
          │ Stack │
          ├───────┤
          │   2   │
          │   1   │
          └───────┘
        OUTPUT
        expect { @stack.view }.to output(expected).to_stdout
      end

      it "can print with custom header" do
        stack = Stack.new "Reg"
        stack.push 1
        stack.push 2
        stack.push 3
        expected = <<~OUTPUT
          ┌─────┐
          │ Reg │
          ├─────┤
          │  3  │
          │  2  │
          │  1  │
          └─────┘
        OUTPUT
        expect { stack.view }.to output(expected).to_stdout
      end
    end
  end
end
