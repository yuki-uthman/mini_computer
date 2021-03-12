require_relative "../../lib/mini_computer/stack"
require_relative "../../lib/mini_computer/converter"

RSpec.describe Converter do
  let(:converter) { described_class.new }

  describe "#next" do
    context "when the input stack becomes empty" do
      it "handles StackEmptyError by returning false" do
        converter.input = [2]
        converter.next
        expect(converter.next).to eq false
      end
    end

    context "when there is some left on the ops stack" do
      it "pops the ops to output" do
        converter.state = [[], [1, 2, 3], [:+]]
        converter.next
        expect(converter.state).to eq [[], [1, 2, 3, :+], []]
      end
    end

    context "when popped element is a number" do
      let(:converter) { described_class.new [1, 2, 3] }

      it "pops it to output stack" do
        converter.next
        expect(converter.state).to eq [[1, 2], [3], []]
      end

      it "can use while loop to iterate through to the end" do
        converter.input = [1, 2, 3]
        converter.next while converter.next
        expect(converter.output).to eq [3, 2, 1]
      end
    end

    context "when popped element is an operator" do
      context "with empty ops stack" do
        it "always push to ops stack" do
          converter.input = [:+]
          converter.next
          expect(converter.ops).to eq [:+]
        end
      end

      context "with stronger precedence" do
        it "pops it to ops stack" do
          converter.state = [[:*], [], [:+]]
          converter.next
          expected = [[], [], [:+, :*]]
          expect(converter.state).to eq expected
        end

        it "can use while loop to iterate through to the end" do
          converter.input = [:+, :*]
          converter.next while converter.next
          expected = [[], [:*, :+], []]
          expect(converter.state).to eq expected
        end
      end

      context "with same/weaker precedence" do
        it "pops ops stack and push it to output stack" do
          converter.state = [[:+], [], [:*]]
          converter.next
          expect(converter.state).to eq [[], [:*], [:+]]
        end

        it "can use while loop to iterate through to the end" do
          converter.input = [:+, :*]
          converter.next while converter.next
          expected = [[], [:*, :+], []]
          expect(converter.state).to eq expected
        end
      end
    end

    context "when given complex example" do
      it "can get the correct answer" do
        converter.input = [3, :*, 2, :+, 1]
        converter.next while converter.next
        expect(converter.output).to eq [1, 2, 3, :*, :+]
      end
    end

    context "when given even more complex example" do
      it "can get the correct answer" do
        converter.input = [5, :-, 4, :/, 3, :*, 2, :+, 1]
        converter.next while converter.next
        expected = [1, 2, 3, :*, 4, :/, :+, 5, :-]
        expect(converter.output).to eq expected
      end
    end
  end

  describe "#back" do
    let(:converter) { described_class.new [1, 2, 3] }

    context "when there are previous states" do
      it "restores the previous state" do
        converter.next
        expect(converter.state).to eq [[1, 2], [3], []]

        converter.back
        expect(converter.state).to eq [[1, 2, 3], [], []]
      end

      it "can go back until the beginning" do
        converter.next while converter.next
        expect(converter.output).to eq [3, 2, 1]

        converter.back
        expect(converter.state).to eq [[1], [3, 2], []]

        converter.back
        expect(converter.state).to eq [[1, 2], [3], []]

        converter.back
        expect(converter.state).to eq [[1, 2, 3], [], []]
      end

      it "returns true" do
        converter.next
        expect(converter.back).to eq true
      end
    end

    context "when there is no previous state" do
      it "keeps the same state" do
        converter.back
        expect(converter.state).to eq [[1, 2, 3], [], []]
      end

      it "returns false" do
        expect(converter.back).to eq false
      end
    end
  end
end
