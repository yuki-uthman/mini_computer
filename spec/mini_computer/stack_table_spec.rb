require_relative "../../lib/mini_computer/stack"
require_relative "../../lib/mini_computer/stack_table"

RSpec.describe StackTable do
  let(:empty_table) { described_class.new }
  let(:numbers) { Stack.new with: [1, 2, 3] }
  let(:letters) { Stack.new with: %(a b c) }

  describe "#add" do
    context "when there is no existing stack" do
      it "adds to the empty table" do
        empty_table.add numbers
        expect(empty_table.stacks).to eq [numbers]
      end
    end

    context "when there an element in the table" do
      it "adds the new stack at the end" do
        empty_table.add numbers
        empty_table.add letters

        expect(empty_table.stacks).to eq [numbers, letters]
      end
    end

    context "when given multiple args" do
      it "is same as adding one by one" do
        empty_table.add numbers, letters

        expected = described_class.new
        expected.add numbers
        expected.add letters

        expect(empty_table).to eq expected
      end
    end
  end

  describe "#render" do
    context "when only one stack" do
      it "render one column" do
        empty_table.add numbers
        expected = <<~OUTPUT.rstrip
          ┌───────┐
          │ Stack │
          ├───────┤
          │   3   │
          │   2   │
          │   1   │
          └───────┘
        OUTPUT
        expect(empty_table.render).to eq expected
      end
    end

    context "when there are more than one stack" do
      it "renders columns side by side" do
        infix = Stack.new header: "Infix", with: [3, 8, 1, 5, 6]
        ops = Stack.new header: "Ops", with: ["+", "*"]
        output = Stack.new header: "Output", with: [30]

        empty_table.add infix, ops, output
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
        expect(empty_table.render).to eq expected
      end
    end
  end
end
