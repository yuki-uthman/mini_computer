require_relative "../../lib/mini_computer/stack"
require_relative "../../lib/mini_computer/stack_table"

RSpec.describe "StackTable class" do
  before do
    @table = StackTable.new
  end

  describe "#add" do
    it "accepts array of stacks" do
      infix = Stack.new header: "Infix", stack: [3, 8, 1, 5, 6]
      ops    = Stack.new header: "Ops",    stack: ["+", "*"]
      output = Stack.new header: "Output", stack: [30]
      expected = StackTable.new
      expected.add [infix]
      expected.add [ops]
      expected.add [output]

      actual = StackTable.new
      actual.add [infix, ops, output]
      expect(actual).to eq expected
    end
  end

  describe "#render" do
    context "given only one stack" do
      it "render one column" do
        stack = Stack.new
        stack.push 1
        stack.push 2
        stack.push 3
        @table.add [stack]
        actual = @table.render
        expected = <<~OUTPUT.rstrip
          ┌───────┐
          │ Stack │
          ├───────┤
          │   3   │
          │   2   │
          │   1   │
          └───────┘
        OUTPUT
        expect(actual).to eq expected
      end
    end

    context "given more than one stack" do
      it "can render columns side by side" do
        infix  = Stack.new header: "Infix",  stack: [3, 8, 1, 5, 6]
        ops    = Stack.new header: "Ops",    stack: ["+", "*"]
        output = Stack.new header: "Output", stack: [30]
        # @table.add [infix]
        # @table.add [ops]
        # @table.add [output]

        @table.add [infix, ops, output]
        actual = @table.render
        expected = <<~OUTPUT.rstrip
          ┌───────┬─────┬────────┐
          │ Infix │ Ops │ Output │
          ├───────┼─────┼────────┤
          │   6   │     │        │
          │   5   │     │        │
          │   1   │     │        │
          │   8   │  *  │        │
          │   3   │  +  │   30   │
          └───────┴─────┴────────┘
        OUTPUT
        expect(actual).to eq expected
      end
    end # context
  end # describe #render
end # RSpec
